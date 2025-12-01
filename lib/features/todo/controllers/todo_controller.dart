import 'package:demo/core/services/storage_service.dart';
import 'package:demo/features/todo/models/task_model.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();

  // Reactive list of tasks
  final tasks = <TaskModel>[].obs;

  // rule toggles stored in Map<String,bool>
  final ruleToggles = <String, bool>{
    'max_total_time_240': true,
    'sort_by_priority': true,
    'prefer_shorter_within_priority': true,
    'include_at_least_two_categories': true,
    'warn_if_high_excluded': true,
  }.obs;

  // Suggested tasks (computed)
  final suggested = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFromStorage();
    ever(tasks, (_) => persistTasks());
    ever(ruleToggles, (_) => persistSettings());
    computeSuggestions();
    // recompute suggestions when tasks or toggles change
    tasks.listen((_) => computeSuggestions());
  }

  // Storage operations
  void loadFromStorage() {
    final raw = _storage.getAllTasks();
    tasks.assignAll(raw.map((m) => TaskModel.fromJson(m)).toList());

    final settings = _storage.getSettings();
    if (settings.isNotEmpty) {
      final toggles = <String, bool>{};
      for (final k in ruleToggles.keys) {
        toggles[k] = settings[k] == null ? ruleToggles[k]! : (settings[k] as bool);
      }
      ruleToggles.assignAll(toggles);
    }
  }

  void persistTasks() {
    final jsonList = tasks.map((t) => t.toJson()).toList();
    _storage.saveAllTasks(jsonList);
  }

  void persistSettings() {
    _storage.saveSettings(ruleToggles);
  }

  // CRUD
  void addTask(TaskModel task) {
    tasks.add(task);
    computeSuggestions();
  }

  void updateTask(TaskModel updated) {
    final idx = tasks.indexWhere((t) => t.id == updated.id);
    if (idx != -1) tasks[idx] = updated;
    computeSuggestions();
  }

  void toggleComplete(String id) {
    final idx = tasks.indexWhere((t) => t.id == id);
    if (idx == -1) return;
    final t = tasks[idx];
    tasks[idx] = TaskModel(
      id: t.id,
      title: t.title,
      priority: t.priority,
      category: t.category,
      estimatedMinutes: t.estimatedMinutes,
      completed: !t.completed,
      createdAt: t.createdAt,
    );
    computeSuggestions();
  }

  void deleteTask(String id) {
    tasks.removeWhere((t) => t.id == id);
    computeSuggestions();
  }

  // RULE ENGINE (initial implementation)
  void computeSuggestions() {
    final active = Map<String, bool>.from(ruleToggles);

    // base candidate: incomplete tasks
    final candidates = tasks.where((t) => !t.completed).toList();

    // 1. Sort by rules: priority and within same priority prefer shorter tasks
    if (active['sort_by_priority'] == true) {
      candidates.sort((a, b) {
        // priority weight
        final weight = {Priority.high: 2, Priority.medium: 1, Priority.low: 0};
        final pa = weight[a.priority]!;
        final pb = weight[b.priority]!;
        if (pa != pb) return pb.compareTo(pa); // high first
        // within same priority prefer shorter
        if (active['prefer_shorter_within_priority'] == true) {
          return a.estimatedMinutes.compareTo(b.estimatedMinutes);
        }
        return a.createdAt.compareTo(b.createdAt);
      });
    } else {
      // If not sorting by priority but still prefer shorter:
      if (active['prefer_shorter_within_priority'] == true) {
        candidates.sort((a, b) => a.estimatedMinutes.compareTo(b.estimatedMinutes));
      } else {
        candidates.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }
    }

    // 2. Pick tasks until total estimatedTime <= 240 (if rule active)
    final selected = <TaskModel>[];
    var total = 0;
    const maxTotal = 240;

    for (final t in candidates) {
      // If including would exceed and rule is active, skip
      if (active['max_total_time_240'] == true && total + t.estimatedMinutes > maxTotal) {
        continue;
      }
      selected.add(t);
      total += t.estimatedMinutes;
    }

    // 3. Try to ensure at least two categories if rule active
    if (active['include_at_least_two_categories'] == true) {
      final categories = selected.map((e) => e.category).toSet();
      if (categories.length < 2) {
        // try to add one more from other category (if any exist and doesn't bust max time)
        final otherCandidates = candidates.where((c) => !selected.contains(c) && !categories.contains(c.category));
        for (final oc in otherCandidates) {
          if (active['max_total_time_240'] == true && total + oc.estimatedMinutes > maxTotal) continue;
          selected.add(oc);
          total += oc.estimatedMinutes;
          categories.add(oc.category);
          if (categories.length >= 2) break;
        }
      }
    }

    // 4. Warning condition: if a high priority task couldn't be factored due to max time limit
    bool highExcludedWarning = false;
    if (active['warn_if_high_excluded'] == true && active['max_total_time_240'] == true) {
      final highTasks = tasks.where((t) => t.priority == Priority.high && !t.completed).toList();
      for (final ht in highTasks) {
        if (!selected.any((s) => s.id == ht.id)) {
          // check if ht could have been added if we allowed exceeding
          if (ht.estimatedMinutes <= maxTotal) {
            // but it was skipped because adding it would have caused a different packing; mark warning
            highExcludedWarning = true;
            break;
          }
        }
      }
    }

    suggested.assignAll(selected);

    // Keep the warning accessible (you can extend controller with an RxBool)
    _highExcludedWarning.value = highExcludedWarning;
  }

  final _highExcludedWarning = false.obs;

  bool get highExcludedWarning => _highExcludedWarning.value;

  // toggle a rule
  void toggleRule(String key) {
    if (!ruleToggles.containsKey(key)) return;
    ruleToggles[key] = !ruleToggles[key]!;
    computeSuggestions();
  }
}
