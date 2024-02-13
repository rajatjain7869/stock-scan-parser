import 'package:get/get.dart';
import 'package:stock_scan_parser/modules/stock_scan_parser_home/view/stock_scan_home.dart';
import 'package:stock_scan_parser/modules/stock_scan_parser_home/view/sub_criteria_view.dart';
import '../modules/stock_scan_parser_home/bindings/stock_scan_binding.dart';
import '../modules/stock_scan_parser_home/view/criteria_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initialRoute = Routes.home;

  static final List<GetPage> routes = [
    GetPage(
        name: Routes.home,
        page: () => const StockScanParserHome(),
        binding: StockScanParserHomeBinding()),
    GetPage(
      name: Routes.criteriaView,
      page: () =>
          CriteriaView(indexOfSection: Get.arguments['indexOfSection'] ?? 0),
    ),
    GetPage(
      name: Routes.subCriteriaView,
      page: () =>
          SubCriteriaView(selectedData: Get.arguments['selectedData'] ?? {}),
    ),
  ];
}
