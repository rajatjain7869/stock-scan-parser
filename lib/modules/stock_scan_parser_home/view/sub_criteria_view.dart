import 'package:flutter/material.dart';
import 'package:stock_scan_parser/modules/stock_scan_parser_home/view/widget/sub_criteria_type_indicator_widget.dart';

import '../../utils/criteria_type_enum.dart';
import 'widget/sub_criteria_type_value_widget.dart';

class SubCriteriaView extends StatelessWidget {
  final Map<String, dynamic> selectedData;

  const SubCriteriaView({Key? key, required this.selectedData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract variable data from the selectedData map.
    final variableData = selectedData;

    debugPrint(" selectedData |$variableData");

    final subCriteriaType =
        SubCriteriaType.getTypeFromString(variableData['type']);

    // this is the method for build the UI based on the sub-criteria type.
    Widget getSubCriteriaWidget(SubCriteriaType subCriteriaType) {
      switch (subCriteriaType) {
        case SubCriteriaType.indicator:
          return SubCriteriaIndicatorWidget(variableData: variableData);
        case SubCriteriaType.valueType:
          return SubCriteriaValueWidget(variableData: variableData);
        default:
          return const SizedBox();
      }
    }

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            "Sub Criteria View ",
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: getSubCriteriaWidget(subCriteriaType)));
  }
}
