import 'package:demo/core/constants/label_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../todo/controllers/todo_controller.dart';

class SuggestionList extends StatelessWidget {
  SuggestionList({super.key});

  final TodoController ctrl = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = ctrl.suggested;

      if (list.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(LabelConst.noSuggestionsForToday),
        );
      }

      return SizedBox(
        height: 140,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemBuilder: (_, index) {
            final item = list[index];
            return SizedBox(
              width: 250,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text('${LabelConst.categoryLabel}: ${item.category}'),
                      const SizedBox(height: 6),
                      Text('${LabelConst.priorityLabel}: ${item.priority.name.toUpperCase()}'),
                      const Spacer(),
                      Text('${item.estimatedMinutes} min'),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemCount: list.length,
        ),
      );
    });
  }
}
