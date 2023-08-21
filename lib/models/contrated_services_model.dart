// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:Mark/models/contratedModels/logo_contrated_item_model.dart';
import 'package:Mark/models/contratedModels/site_contrated_item_model.dart';
import 'package:Mark/models/contratedModels/social_contrated_item_model.dart';

class ContratedServiceModel {
  int id = 0;
  int companieId = 0;
  List<SiteContratedItem> SiteContratedItems;
  List<SocialContratedItem> SocialContratedItems;
  List<LogoContratedItem> LogoContratedItems;
  ContratedServiceModel({
    required this.id,
    required this.companieId,
    required this.SiteContratedItems,
    required this.SocialContratedItems,
    required this.LogoContratedItems,
  });

  ContratedServiceModel copyWith({
    int? id,
    int? companieId,
    List<SiteContratedItem>? SiteContratedItems,
    List<SocialContratedItem>? SocialContratedItems,
    List<LogoContratedItem>? LogoContratedItems,
  }) {
    return ContratedServiceModel(
      id: id ?? this.id,
      companieId: companieId ?? this.companieId,
      SiteContratedItems: SiteContratedItems ?? this.SiteContratedItems,
      SocialContratedItems: SocialContratedItems ?? this.SocialContratedItems,
      LogoContratedItems: LogoContratedItems ?? this.LogoContratedItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companieId': companieId,
      'SiteContratedItems': SiteContratedItems.map((x) => x.toMap()).toList(),
      'SocialContratedItems':
          SocialContratedItems.map((x) => x.toMap()).toList(),
      'LogoContratedItems': LogoContratedItems.map((x) => x.toMap()).toList(),
    };
  }

  factory ContratedServiceModel.fromMap(Map<String, dynamic> map) {
    return ContratedServiceModel(
      id: map['id'] as int,
      companieId: map['companiesId'] as int,
      SiteContratedItems: map.containsKey("SiteContratedItems")
          ? List<SiteContratedItem>.from(
              (map['SiteContratedItems'] as List).map<SiteContratedItem>(
                (x) => SiteContratedItem.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      SocialContratedItems: map.containsKey("SocialContratedItems")
          ? List<SocialContratedItem>.from(
              (map['SocialContratedItems'] as List).map<SocialContratedItem>(
                (x) => SocialContratedItem.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      LogoContratedItems: map.containsKey("LogoContratedItems")
          ? List<LogoContratedItem>.from(
              (map['LogoContratedItems'] as List).map<LogoContratedItem>(
                (x) => LogoContratedItem.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContratedServiceModel.fromJson(String source) =>
      ContratedServiceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContratedServiceModel(id: $id, companieId: $companieId, SiteContratedItems: $SiteContratedItems, SocialContratedItems: $SocialContratedItems, LogoContratedItems: $LogoContratedItems)';
  }

  @override
  bool operator ==(covariant ContratedServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.companieId == companieId &&
        listEquals(other.SiteContratedItems, SiteContratedItems) &&
        listEquals(other.SocialContratedItems, SocialContratedItems) &&
        listEquals(other.LogoContratedItems, LogoContratedItems);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companieId.hashCode ^
        SiteContratedItems.hashCode ^
        SocialContratedItems.hashCode ^
        LogoContratedItems.hashCode;
  }
}
