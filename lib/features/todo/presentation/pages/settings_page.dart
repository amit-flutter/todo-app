import 'package:demo/core/constants/label_const.dart';
import 'package:demo/features/todo/controllers/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final TodoController ctrl = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LabelConst.settingsTitle),
      ),
      body: Obx(() {
        final toggles = ctrl.ruleToggles;
        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            SwitchListTile(
              title: const Text(LabelConst.ruleMaxTotalTime),
              value: toggles['max_total_time_240'] ?? true,
              onChanged: (_) => ctrl.toggleRule('max_total_time_240'),
            ),
            SwitchListTile(
              title: const Text(LabelConst.ruleSortByPriority),
              value: toggles['sort_by_priority'] ?? true,
              onChanged: (_) => ctrl.toggleRule('sort_by_priority'),
            ),
            SwitchListTile(
              title: const Text(LabelConst.rulePreferShorterWithinPriority),
              value: toggles['prefer_shorter_within_priority'] ?? true,
              onChanged: (_) => ctrl.toggleRule('prefer_shorter_within_priority'),
            ),
            SwitchListTile(
              title: const Text(LabelConst.ruleIncludeTwoCategories),
              value: toggles['include_at_least_two_categories'] ?? true,
              onChanged: (_) => ctrl.toggleRule('include_at_least_two_categories'),
            ),
            SwitchListTile(
              title: const Text(LabelConst.ruleWarnIfHighExcluded),
              value: toggles['warn_if_high_excluded'] ?? true,
              onChanged: (_) => ctrl.toggleRule('warn_if_high_excluded'),
            ),
          ],
        );
      }),
    );
  }
}
