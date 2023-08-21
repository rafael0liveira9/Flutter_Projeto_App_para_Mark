import 'dart:convert';

import 'package:Mark/models/contratedModels/site_contrated_item_model.dart';

class SiteLayoutBaseControllerModel {
  SiteLayoutBaseModel layout;
  bool isSelected = false;
  SiteLayoutBaseControllerModel({
    required this.layout,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'layout': layout.toMap(),
    };
  }

  factory SiteLayoutBaseControllerModel.fromMap(Map<String, dynamic> map) {
    return SiteLayoutBaseControllerModel(
      layout:
          SiteLayoutBaseModel.fromMap(map['layout'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SiteLayoutBaseControllerModel.fromJson(String source) =>
      SiteLayoutBaseControllerModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
