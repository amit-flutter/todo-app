import 'package:demo/core/constants/label_const.dart';
import 'package:demo/core/routes/app_routes.dart';
import 'package:demo/features/todo/controllers/todo_controller.dart';
import 'package:demo/features/todo/presentation/dialogs/add_task_dialog.dart';
import 'package:demo/features/todo/presentation/widgets/all_tasks_list.dart';
import 'package:demo/features/todo/presentation/widgets/high_priority_warning.dart';
import 'package:demo/features/todo/presentation/widgets/suggestion_header.dart';
import 'package:demo/features/todo/presentation/widgets/suggestion_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TodoController ctrl = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LabelConst.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed(Routes.settingScreen),
          ),
        ],
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SuggestionHeader(),
            SuggestionList(),
            HighPriorityWarning(),
            const Divider(),
            Expanded(child: AllTasksList()),
          ],
        ),
      ),
    );
  }
}
