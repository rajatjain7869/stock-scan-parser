
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';

void main() {
  runApp(const StockScanParserApp());
}

class StockScanParserApp extends StatelessWidget {
  const StockScanParserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        color: Colors.blue, //<-- SEE HERE
      )),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      initialRoute: Routes.home,

      defaultTransition: Transition.fadeIn,
    );
  }
}
