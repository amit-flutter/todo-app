import 'package:demo/core/routes/app_routes.dart';
import 'package:demo/features/todo/controllers/todo_controller.dart';
import 'package:demo/features/todo/models/task_model.dart';
import 'package:demo/features/todo/presentation/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TodoController ctrl = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart ToDo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed(Routes.settingScreen),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Suggested for today
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: const [
                  Icon(Icons.lightbulb),
                  SizedBox(width: 8),
                  Text('Suggested for today', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Obx(() {
              final list = ctrl.suggested;
              if (list.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('No suggestions for today.'),
                );
              }
              return SizedBox(
                height: 140,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (c, i) => SizedBox(
                    width: 260,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(list[i].title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text('Category: ${list[i].category}'),
                            const SizedBox(height: 6),
                            Text('Priority: ${list[i].priority.name.toUpperCase()}'),
                            const Spacer(),
                            Text('${list[i].estimatedMinutes} min'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemCount: list.length,
                ),
              );
            }),

            // Warning banner if needed
            Obx(() {
              if (ctrl.highExcludedWarning) {
                return Container(
                  width: double.infinity,
                  color: Colors.orange.shade100,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: const [
                      Icon(Icons.warning, color: Colors.orange),
                      SizedBox(width: 8),
                      Expanded(child: Text('Some high priority tasks were excluded due to time limit.')),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            const Divider(),

            // All tasks list
            Expanded(
              child: Obx(() {
                final list = ctrl.tasks;
                if (list.isEmpty) {
                  return const Center(child: Text('No tasks yet. Tap + to add one.'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) => TaskTile(task: list[i]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    var priority = Priority.medium;
    var category = 'Work';
    var estimated = 30;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Task'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
              const SizedBox(height: 8),
              DropdownButtonFormField<Priority>(
                value: priority,
                items:
                    Priority.values.map((p) => DropdownMenuItem(value: p, child: Text(p.name.toUpperCase()))).toList(),
                onChanged: (v) => priority = v ?? Priority.medium,
                decoration: const InputDecoration(labelText: 'Priority'),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: category,
                items: ['Work', 'Personal', 'Health'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => category = v ?? 'Work',
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: estimated.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Estimated time (minutes)'),
                onChanged: (v) => estimated = int.tryParse(v) ?? 30,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final title = titleCtrl.text.trim();
              if (title.isEmpty) {
                Get.snackbar('Validation', 'Title is required');
                return;
              }
              final task = TaskModel(
                title: title,
                priority: priority,
                category: category,
                estimatedMinutes: estimated,
              );
              Get.find<TodoController>().addTask(task);
              Get.back();
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
