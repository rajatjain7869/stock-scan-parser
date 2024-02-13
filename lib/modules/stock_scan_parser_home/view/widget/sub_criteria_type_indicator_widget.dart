import 'package:flutter/material.dart';
import 'package:stock_scan_parser/modules/utils/extension_on_string.dart';

class SubCriteriaIndicatorWidget extends StatelessWidget {
  const SubCriteriaIndicatorWidget({super.key, required this.variableData});

  final Map<String, dynamic> variableData;

  @override
  Widget build(BuildContext context) {
    final min = variableData['min_value'];
    final max = variableData['max_value'];
    final defaultValue = variableData['default_value'];
    final String title = variableData['study_type'];
    final String parameterName = variableData['parameter_name'];
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          title.toString().toUpperCase(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Set Parameters",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  parameterName.capitalizeFirstLetter(),
                  style: textTheme.titleMedium,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: '$defaultValue',
                    decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(10, 10),
                          ),
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        helperStyle: TextStyle(color: Colors.white)),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      final inputValue = double.tryParse(value);
                      if (inputValue == null ||
                          inputValue < min ||
                          inputValue > max) {
                        return 'Invalid value. Must be between $min and $max';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
