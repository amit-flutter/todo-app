import 'package:demo/features/todo/controllers/todo_controller.dart';
import 'package:demo/features/todo/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/core/constants/label_const.dart';

void showAddTaskDialog(BuildContext context) {
  final titleCtrl = TextEditingController();
  var priority = Priority.medium;
  var category = LabelConst.categoryWork;
  var estimated = 30;

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text(LabelConst.addTaskTitle),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: LabelConst.taskTitleLabel,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<Priority>(
              value: priority,
              items: Priority.values.map((p) => DropdownMenuItem(value: p, child: Text(p.name.toUpperCase()))).toList(),
              onChanged: (v) => priority = v ?? Priority.medium,
              decoration: const InputDecoration(labelText: LabelConst.priorityLabel),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: category,
              items: [
                LabelConst.categoryWork,
                LabelConst.categoryPersonal,
                LabelConst.categoryHealth,
              ].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => category = v ?? LabelConst.categoryWork,
              decoration: const InputDecoration(labelText: LabelConst.categoryLabel),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: estimated.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: LabelConst.estimatedTimeLabel,
              ),
              onChanged: (v) => estimated = int.tryParse(v) ?? 30,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(LabelConst.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            final title = titleCtrl.text.trim();
            if (title.isEmpty) {
              Get.snackbar(LabelConst.validation, LabelConst.titleRequired);
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
          child: const Text(LabelConst.add),
        ),
      ],
    ),
  );
}
