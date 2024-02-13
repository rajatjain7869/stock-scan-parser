import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stock_scan_parser/main.dart';
import 'package:stock_scan_parser/modules/stock_scan_parser_home/controller/stock_scan_parser_home_controller.dart';
import 'package:stock_scan_parser/modules/stock_scan_parser_home/model/stock_scan_parser_model.dart';
import 'package:stock_scan_parser/modules/stock_scan_parser_home/repository/stock_scan_parser_repo.dart';

// Mock the StockScanRepository
class MockStockScanRepository extends Mock implements StockScanRepository {
  @override
  Future<dynamic> getHomeData() {
    return Future.value(List<StockScanParserModel>.from(
      [
        {
          "id": 1,
          "name": "Top gainers",
          "tag": "Intraday Bullish",
          "color": "green",
          "criteria": [
            {
              "type": "plain_text",
              "text": "Sort - %price change in descending order"
            }
          ]
        },
        {
          "id": 2,
          "name": "Intraday buying seen in last 15 minutes",
          "tag": "Bullish",
          "color": "green",
          "criteria": [
            {
              "type": "plain_text",
              "text": "Current candle open = current candle high"
            },
            {
              "type": "plain_text",
              "text": "Previous candle open = previous candle high"
            },
            {
              "type": "plain_text",
              "text": "2 previous candle’s open = 2 previous candle’s high"
            }
          ]
        },
        {
          "id": 3,
          "name": "Open = High",
          "tag": "Bullish",
          "color": "green",
          "criteria": [
            {
              "type": "variable",
              "text": "Today’s open < yesterday’s low by \$1 %",
              "variable": {
                "\$1": {
                  "type": "value",
                  "values": [-3, -1, -2, -5, -10]
                }
              }
            }
          ]
        },
        {
          "id": 4,
          "name": "CCI Reversal",
          "tag": "Bearish",
          "color": "red",
          "criteria": [
            {
              "type": "variable",
              "text": "CCI \$1 crosses below \$2",
              "variable": {
                "\$1": {
                  "type": "indicator",
                  "study_type": "cci",
                  "parameter_name": "period",
                  "min_value": 1,
                  "max_value": 99,
                  "default_value": 20
                },
                "\$2": {
                  "type": "value",
                  "values": [100, 200]
                }
              }
            }
          ]
        },
        {
          "id": 5,
          "name": "RSI Overbought",
          "tag": "Bearish",
          "color": "red",
          "criteria": [
            {
              "type": "variable",
              "text":
                  "Max of last 5 days close > Max of last 120 days close by \$1 %",
              "variable": {
                "\$1": {
                  "type": "value",
                  "values": [2, 1, 3, 5]
                }
              }
            },
            {
              "type": "variable",
              "text": "Today's Volume > prev \$2 Vol SMA by \$3 x",
              "variable": {
                "\$2": {
                  "type": "value",
                  "values": [10, 5, 20, 30]
                },
                "\$3": {
                  "type": "value",
                  "values": [1.5, 0.5, 1, 2, 3]
                }
              }
            },
            {
              "type": "variable",
              "text": "RSI \$4 > 20",
              "variable": {
                "\$4": {
                  "type": "indicator",
                  "study_type": "rsi",
                  "parameter_name": "period",
                  "min_value": 1,
                  "max_value": 99,
                  "default_value": 14
                }
              }
            }
          ]
        }
      ].map(
        (x) => StockScanParserModel.fromJson(x),
      ),
    ));
  }
}

void main() {
  testWidgets('Fit Page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StockScanParserApp());
    await tester.pumpAndSettle();
    // Verify that our counter starts at 0.
    expect(find.text('Stock Scan Home'), findsOneWidget);
    expect(find.text('Bullish'), findsNothing);
  });

  group('Testing Controller initialisations', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    test('StockScanHomeController binding test', () async {
      final instance = Get.put<StockScanParserHomeController>(
          StockScanParserHomeController());
      expect(instance, Get.find<StockScanParserHomeController>());
      Get.reset();
    });
  });

  group('StockScanHomeController Tests', () {
    late StockScanParserHomeController controller;
    late MockStockScanRepository mockRepository;

    setUp(() {
      mockRepository = MockStockScanRepository();
      controller = StockScanParserHomeController();
    });

    test('Initial state of stockScanList', () {
      expect(controller.stockScanList, isEmpty);
    });

    test('Test getInitData with successful response', () async {
// Mock the getHomeData method of the repository to return mock data
      final mockData = List<StockScanParserModel>.from(
        [
          {
            "id": 1,
            "name": "Top gainers",
            "tag": "Intraday Bullish",
            "color": "green",
            "criteria": [
              {
                "type": "plain_text",
                "text": "Sort - %price change in descending order"
              }
            ]
          },
          {
            "id": 2,
            "name": "Intraday buying seen in last 15 minutes",
            "tag": "Bullish",
            "color": "green",
            "criteria": [
              {
                "type": "plain_text",
                "text": "Current candle open = current candle high"
              },
              {
                "type": "plain_text",
                "text": "Previous candle open = previous candle high"
              },
              {
                "type": "plain_text",
                "text": "2 previous candle’s open = 2 previous candle’s high"
              }
            ]
          },
          {
            "id": 3,
            "name": "Open = High",
            "tag": "Bullish",
            "color": "green",
            "criteria": [
              {
                "type": "variable",
                "text": "Today’s open < yesterday’s low by \$1 %",
                "variable": {
                  "\$1": {
                    "type": "value",
                    "values": [-3, -1, -2, -5, -10]
                  }
                }
              }
            ]
          },
          {
            "id": 4,
            "name": "CCI Reversal",
            "tag": "Bearish",
            "color": "red",
            "criteria": [
              {
                "type": "variable",
                "text": "CCI \$1 crosses below \$2",
                "variable": {
                  "\$1": {
                    "type": "indicator",
                    "study_type": "cci",
                    "parameter_name": "period",
                    "min_value": 1,
                    "max_value": 99,
                    "default_value": 20
                  },
                  "\$2": {
                    "type": "value",
                    "values": [100, 200]
                  }
                }
              }
            ]
          },
          {
            "id": 5,
            "name": "RSI Overbought",
            "tag": "Bearish",
            "color": "red",
            "criteria": [
              {
                "type": "variable",
                "text":
                    "Max of last 5 days close > Max of last 120 days close by \$1 %",
                "variable": {
                  "\$1": {
                    "type": "value",
                    "values": [2, 1, 3, 5]
                  }
                }
              },
              {
                "type": "variable",
                "text": "Today's Volume > prev \$2 Vol SMA by \$3 x",
                "variable": {
                  "\$2": {
                    "type": "value",
                    "values": [10, 5, 20, 30]
                  },
                  "\$3": {
                    "type": "value",
                    "values": [1.5, 0.5, 1, 2, 3]
                  }
                }
              },
              {
                "type": "variable",
                "text": "RSI \$4 > 20",
                "variable": {
                  "\$4": {
                    "type": "indicator",
                    "study_type": "rsi",
                    "parameter_name": "period",
                    "min_value": 1,
                    "max_value": 99,
                    "default_value": 14
                  }
                }
              }
            ]
          }
        ].map(
          (x) => StockScanParserModel.fromJson(x),
        ),
      );

      controller.scanRepository = mockRepository;
      await controller.getInitData();

      // Verify that stockScanList has been populated with mock data
      expect(controller.stockScanList[0].runtimeType,
          equals(mockData[0].runtimeType));
    });

    test('Test getInitData with error response', () async {
      // Mock the getHomeData method of the repository to throw an exception

      controller.scanRepository = StockScanRepository();

      await controller.getInitData();

      // Verify that stockScanList is still empty
      expect(controller.stockScanList, isEmpty);
    });
  });
}
