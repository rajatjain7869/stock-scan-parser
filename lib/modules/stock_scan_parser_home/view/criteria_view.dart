import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/color_parser.dart';
import '../../utils/criteria_type_enum.dart';
import '../controller/stock_scan_parser_home_controller.dart';
import '../model/stock_scan_parser_model.dart';
import 'widget/plain_text_section.dart';
import 'widget/variable_text_section.dart';

class CriteriaView extends GetView<StockScanParserHomeController> {
  final int indexOfSection;

  const CriteriaView({Key? key, required this.indexOfSection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final criteriaList = controller.stockScanList[indexOfSection].criteria;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Criteria')),
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                      width: Get.width,
                      child: ColoredBox(
                        color: const Color(0xff1686B0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.stockScanList[indexOfSection].name ??
                                    '',
                                style: textTheme.titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                              Text(
                                  controller
                                          .stockScanList[indexOfSection].tag ??
                                      '',
                                  style: textTheme.bodySmall?.copyWith(
                                      color: ColorParser.getColor(controller
                                              .stockScanList[indexOfSection]
                                              .color ??
                                          ''))),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...(criteriaList ?? [])
                        .asMap()
                        .entries
                        .map((value) => CustomCriteriaSection(
                            indexOfCriteria: value.key,
                            criteriaList: criteriaList ?? []))
                        .toList()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCriteriaSection extends StatelessWidget {
  final List<Criteria> criteriaList;
  final int indexOfCriteria;

  const CustomCriteriaSection(
      {Key? key, required this.indexOfCriteria, required this.criteriaList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (criteriaList[indexOfCriteria].type) {
      case CriteriaType.variable:
        return VariableTextSection(
            index: indexOfCriteria, criteriaList: criteriaList);

      case CriteriaType.plainText:
        return PlainTextSection(
            index: indexOfCriteria, criteriaList: criteriaList);

      default:
        return const SizedBox
            .shrink(); // Handle other criterion types as needed
    }
  }
}
