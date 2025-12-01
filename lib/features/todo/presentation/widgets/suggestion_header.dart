import 'package:demo/core/constants/label_const.dart';
import 'package:flutter/material.dart';

class SuggestionHeader extends StatelessWidget {
  const SuggestionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Row(
        children: [
          Icon(Icons.lightbulb),
          SizedBox(width: 8),
          Text(LabelConst.suggestionForToday, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
