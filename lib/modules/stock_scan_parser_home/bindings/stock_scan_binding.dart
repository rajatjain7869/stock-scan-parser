import 'package:get/get.dart';

import '../controller/stock_scan_parser_home_controller.dart';

class StockScanParserHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StockScanParserHomeController());
  }
}
