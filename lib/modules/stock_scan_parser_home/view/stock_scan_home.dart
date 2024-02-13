import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../utils/color_parser.dart';
import '../controller/stock_scan_parser_home_controller.dart';
import 'widget/dotted_line.dart';

class StockScanParserHome extends GetView<StockScanParserHomeController> {
  const StockScanParserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Scan Parser')),
      body: SafeArea(
        child: FutureBuilder(
            future: controller.getInitData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.stockScanList.isEmpty) {
                return const Center(
                  child: Text("Something Went Wrong Please Try Again Later!"),
                );
              }
              return Card(
                margin: const EdgeInsets.all(10),
                color: Colors.black,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.stockScanList.length,
                  itemBuilder: (context, index) {
                    final scanModel = controller.stockScanList[index];

                    return ListTile(
                      title: Text(
                        scanModel.name ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      subtitle: Text(scanModel.tag ?? '',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              color:
                                  ColorParser.getColor(scanModel.color ?? ''))),
                      onTap: () {
                        Get.toNamed(Routes.criteriaView,
                            arguments: {'indexOfSection': index});
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: DottedLine(
                        color: Colors.white,
                        height: 1.0,
                        width: 200.0,
                        spacing: 3.0,
                      ),
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
