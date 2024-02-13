
//StockScan Model Data class
import '../../utils/criteria_type_enum.dart';

class StockScanParserModel {
  int? id;
  String? name;
  String? tag;
  String? color;
  List<Criteria>? criteria;

  StockScanParserModel({this.id, this.name, this.tag, this.color, this.criteria});

  StockScanParserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tag = json['tag'];
    color = json['color'];
    if (json['criteria'] != null) {
      criteria = <Criteria>[];
      json['criteria'].forEach((v) {
        criteria!.add(Criteria.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tag'] = tag;
    data['color'] = color;
    if (criteria != null) {
      data['criteria'] = criteria!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Criteria {
  CriteriaType? type;
  String? text;
  Map<String, dynamic>? variable;

  Criteria({this.type, this.text, this.variable});

  Criteria.fromJson(Map<String, dynamic> json) {
    type = json['type'] != null
        ? CriteriaType.getTypeFromString(json['type'])
        : null;
    text = json['text'];
    variable = json['type'] == "variable" ? json['variable'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['text'] = text;
    data['variable'] = variable;
    return data;
  }
}
