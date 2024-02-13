import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dotted_line.dart';

class SubCriteriaValueWidget extends StatelessWidget {
  const SubCriteriaValueWidget({super.key, required this.variableData});

  final Map<String, dynamic> variableData;

  @override
  Widget build(BuildContext context) {
    final valuesList = variableData['values'] as List;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: valuesList
          .map((value) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$value",
                      style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                  if (valuesList.last != value) ...{
                    DottedLine(
                      color: Colors.white,
                      height: 1.0,
                      width: Get.width,
                      spacing: 2.0,
                    )
                  }
                ],
              ))
          .toList(),
    );
  }
}
