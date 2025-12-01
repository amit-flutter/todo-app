import 'package:demo/features/todo/controllers/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final TodoController ctrl = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rule Engine Settings')),
      body: Obx(() {
        final toggles = ctrl.ruleToggles;
        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            SwitchListTile(
              title: const Text('Max total estimated time ≤ 240 minutes'),
              value: toggles['max_total_time_240'] ?? true,
              onChanged: (_) => ctrl.toggleRule('max_total_time_240'),
            ),
            SwitchListTile(
              title: const Text('Sort by priority'),
              value: toggles['sort_by_priority'] ?? true,
              onChanged: (_) => ctrl.toggleRule('sort_by_priority'),
            ),
            SwitchListTile(
              title: const Text('Within same priority prefer shorter tasks'),
              value: toggles['prefer_shorter_within_priority'] ?? true,
              onChanged: (_) => ctrl.toggleRule('prefer_shorter_within_priority'),
            ),
            SwitchListTile(
              title: const Text('Include at least two categories if possible'),
              value: toggles['include_at_least_two_categories'] ?? true,
              onChanged: (_) => ctrl.toggleRule('include_at_least_two_categories'),
            ),
            SwitchListTile(
              title: const Text('Warn if high priority excluded due to time limit'),
              value: toggles['warn_if_high_excluded'] ?? true,
              onChanged: (_) => ctrl.toggleRule('warn_if_high_excluded'),
            ),
          ],
        );
      }),
    );
  }
}
