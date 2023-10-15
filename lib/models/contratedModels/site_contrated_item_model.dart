// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SiteContratedItem {
  int id = 0;
  int contratedServiceId = 0;
  int serviceId = 0;
  SiteServiceModel SiteService;
  SiteContratedItem({
    required this.id,
    required this.contratedServiceId,
    required this.serviceId,
    required this.SiteService,
  });

  SiteContratedItem copyWith({
    int? id,
    int? contratedServiceId,
    int? serviceId,
    SiteServiceModel? SiteService,
  }) {
    return SiteContratedItem(
      id: id ?? this.id,
      contratedServiceId: contratedServiceId ?? this.contratedServiceId,
      serviceId: serviceId ?? this.serviceId,
      SiteService: SiteService ?? this.SiteService,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'contratedServiceId': contratedServiceId,
      'serviceId': serviceId,
      'SiteService': SiteService.toMap(),
    };
  }

  factory SiteContratedItem.fromMap(Map<String, dynamic> map) {
    print(map);
    return SiteContratedItem(
      id: map['id'] as int,
      contratedServiceId: map['contratedServiceId'] as int,
      serviceId: map['siteServiceId'] as int,
      SiteService:
          SiteServiceModel.fromMap(map['SiteService'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SiteContratedItem.fromJson(String source) =>
      SiteContratedItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SiteContratedItem(id: $id, contratedServiceId: $contratedServiceId, serviceId: $serviceId, SiteService: $SiteService)';
  }

  @override
  bool operator ==(covariant SiteContratedItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.contratedServiceId == contratedServiceId &&
        other.serviceId == serviceId &&
        other.SiteService == SiteService;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        contratedServiceId.hashCode ^
        serviceId.hashCode ^
        SiteService.hashCode;
  }
}

class SiteServiceModel {
  int id = 0;
  int status;
  String? dueDate = "";
  bool? isPublished = false;
  int serviceTypeId = 0;
  int? briefingId = 0;
  int? layoutSelected = 0;
  int? layoutFinished = 0;
  SiteBriefingModel? SiteBriefing;
  List<SiteLayoutBaseModel>? SiteLayoutBase;
  SiteLayoutSelectedModel? SiteLayoutSelected;
  SiteLayoutFinishedModel? SiteLayoutFinished;

  SiteServiceModel({
    required this.id,
    required this.status,
    this.dueDate,
    this.isPublished,
    required this.serviceTypeId,
    this.briefingId,
    this.layoutSelected,
    this.layoutFinished,
    this.SiteBriefing,
    this.SiteLayoutBase,
    this.SiteLayoutSelected,
    this.SiteLayoutFinished,
  });

  SiteServiceModel copyWith({
    int? id,
    int? status,
    String? dueDate,
    bool? isPublished,
    int? serviceTypeId,
    int? briefingId,
    int? layoutSelected,
    int? layoutFinished,
    SiteBriefingModel? SiteBriefing,
    List<SiteLayoutBaseModel>? SiteLayoutBase,
    SiteLayoutSelectedModel? SiteLayoutSelected,
    SiteLayoutFinishedModel? SiteLayoutFinished,
  }) {
    return SiteServiceModel(
      id: id ?? this.id,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      isPublished: isPublished ?? this.isPublished,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      briefingId: briefingId ?? this.briefingId,
      layoutSelected: layoutSelected ?? this.layoutSelected,
      layoutFinished: layoutFinished ?? this.layoutFinished,
      SiteBriefing: SiteBriefing ?? this.SiteBriefing,
      SiteLayoutBase: SiteLayoutBase ?? this.SiteLayoutBase,
      SiteLayoutSelected: SiteLayoutSelected ?? this.SiteLayoutSelected,
      SiteLayoutFinished: SiteLayoutFinished ?? this.SiteLayoutFinished,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'dueDate': dueDate,
      'isPublished': isPublished,
      'serviceTypeId': serviceTypeId,
      'briefingId': briefingId,
      'layoutSelected': layoutSelected,
      'layoutFinished': layoutFinished,
      'SiteBriefing': SiteBriefing?.toMap(),
      'SiteLayoutBase': SiteLayoutBase?.map((x) => x.toMap()).toList(),
      'SiteLayoutSelected': SiteLayoutSelected?.toMap(),
      'SiteLayoutFinished': SiteLayoutFinished?.toMap(),
    };
  }

  factory SiteServiceModel.fromMap(Map<String, dynamic> map) {
    return SiteServiceModel(
      id: map['id'] as int,
      status: map['status'] as int,
      dueDate: map['dueDate'] != null ? map['dueDate'] as String : null,
      isPublished:
          map['isPublished'] != null ? map['isPublished'] as bool : null,
      serviceTypeId: map['serviceTypeId'] as int,
      briefingId: map['briefingId'] != null ? map['briefingId'] as int : null,
      layoutSelected:
          map['layoutSelected'] != null ? map['layoutSelected'] as int : null,
      layoutFinished:
          map['layoutFinished'] != null ? map['layoutFinished'] as int : null,
      SiteBriefing: map['SiteBriefing'] != null
          ? SiteBriefingModel.fromMap(
              map['SiteBriefing'] as Map<String, dynamic>)
          : null,
      SiteLayoutBase: map['SiteLayoutBase'] != null
          ? List<SiteLayoutBaseModel>.from(
              (map['SiteLayoutBase'] as List).map<SiteLayoutBaseModel?>(
                (x) => SiteLayoutBaseModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      SiteLayoutSelected: map['SiteLayoutSelected'] != null
          ? SiteLayoutSelectedModel.fromMap(
              map['SiteLayoutSelected'] as Map<String, dynamic>)
          : null,
      SiteLayoutFinished: map['SiteLayoutFinished'] != null
          ? SiteLayoutFinishedModel.fromMap(
              map['SiteLayoutFinished'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SiteServiceModel.fromJson(String source) =>
      SiteServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SiteServiceModel(id: $id, status: $status, dueDate: $dueDate, isPublished: $isPublished, serviceTypeId: $serviceTypeId, briefingId: $briefingId, layoutSelected: $layoutSelected, layoutFinished: $layoutFinished, SiteBriefing: $SiteBriefing, SiteLayoutBase: $SiteLayoutBase, SiteLayoutSelected: $SiteLayoutSelected, SiteLayoutFinished: $SiteLayoutFinished)';
  }

  @override
  bool operator ==(covariant SiteServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.status == status &&
        other.dueDate == dueDate &&
        other.isPublished == isPublished &&
        other.serviceTypeId == serviceTypeId &&
        other.briefingId == briefingId &&
        other.layoutSelected == layoutSelected &&
        other.layoutFinished == layoutFinished &&
        other.SiteBriefing == SiteBriefing &&
        listEquals(other.SiteLayoutBase, SiteLayoutBase) &&
        other.SiteLayoutSelected == SiteLayoutSelected &&
        other.SiteLayoutFinished == SiteLayoutFinished;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        dueDate.hashCode ^
        isPublished.hashCode ^
        serviceTypeId.hashCode ^
        briefingId.hashCode ^
        layoutSelected.hashCode ^
        layoutFinished.hashCode ^
        SiteBriefing.hashCode ^
        SiteLayoutBase.hashCode ^
        SiteLayoutSelected.hashCode ^
        SiteLayoutFinished.hashCode;
  }
}

class SiteBriefingModel {
  int id = 0;
  String url = "";
  String references = "";
  String? logo = '';
  String? contactData = "";
  String? socialMidia = "";

  SiteBriefingModel({
    required this.id,
    required this.url,
    required this.references,
    required this.logo,
    required this.contactData,
    required this.socialMidia,
  });

  SiteBriefingModel copyWith({
    int? id,
    String? url,
    String? references,
    String? logo,
    String? contactData,
    String? socialMidia,
  }) {
    return SiteBriefingModel(
      id: id ?? this.id,
      url: url ?? this.url,
      references: references ?? this.references,
      logo: logo ?? this.logo,
      contactData: contactData ?? this.contactData,
      socialMidia: socialMidia ?? this.socialMidia,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'references': references,
      'logo': logo,
      'contactData': contactData,
      'socialMidia': socialMidia,
    };
  }

  factory SiteBriefingModel.fromMap(Map<String, dynamic> map) {
    return SiteBriefingModel(
      id: map['id'] as int,
      url: map['url'] as String,
      references: map['references'].toString(),
      logo: map['logo'] as String,
      contactData: map['contactData'] as String,
      socialMidia: map['socialMidia'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SiteBriefingModel.fromJson(String source) =>
      SiteBriefingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SiteBriefingModel(id: $id url: $url, references: $references, logo: $logo, contactData: $contactData, socialMidia: $socialMidia)';
  }

  @override
  bool operator ==(covariant SiteBriefingModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.url == url &&
        other.references == references &&
        other.logo == logo &&
        other.contactData == contactData &&
        other.socialMidia == socialMidia;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        url.hashCode ^
        references.hashCode ^
        logo.hashCode ^
        contactData.hashCode ^
        socialMidia.hashCode;
  }
}

class SiteLayoutBaseModel {
  int id = 0;
  String name = "";
  int layoutId = 0;
  SiteLayoutImage Layout;
  SiteLayoutBaseModel({
    required this.id,
    required this.name,
    required this.layoutId,
    required this.Layout,
  });

  SiteLayoutBaseModel copyWith({
    int? id,
    String? name,
    int? layoutId,
    SiteLayoutImage? Layout,
  }) {
    return SiteLayoutBaseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      layoutId: layoutId ?? this.layoutId,
      Layout: Layout ?? this.Layout,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'layoutId': layoutId,
      'Layout': Layout.toMap(),
    };
  }

  factory SiteLayoutBaseModel.fromMap(Map<String, dynamic> map) {
    return SiteLayoutBaseModel(
      id: map['id'] as int,
      name: map['name'] as String,
      layoutId: map['layoutId'] as int,
      Layout: SiteLayoutImage.fromMap(map['Layout'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SiteLayoutBaseModel.fromJson(String source) =>
      SiteLayoutBaseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SiteLayoutBaseModel(id: $id, name: $name, layoutId: $layoutId, Layout: $Layout)';
  }

  @override
  bool operator ==(covariant SiteLayoutBaseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.layoutId == layoutId &&
        other.Layout == Layout;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ layoutId.hashCode ^ Layout.hashCode;
  }
}

class SiteLayoutSelectedModel {
  int id = 0;
  int layoutId = 0;
  SiteLayoutImage LayoutSelected;
  SiteLayoutSelectedModel({
    required this.id,
    required this.layoutId,
    required this.LayoutSelected,
  });

  SiteLayoutSelectedModel copyWith({
    int? id,
    int? layoutId,
    SiteLayoutImage? LayoutSelected,
  }) {
    return SiteLayoutSelectedModel(
      id: id ?? this.id,
      layoutId: layoutId ?? this.layoutId,
      LayoutSelected: LayoutSelected ?? this.LayoutSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'layoutId': layoutId,
      'LayoutSelected': LayoutSelected.toMap(),
    };
  }

  factory SiteLayoutSelectedModel.fromMap(Map<String, dynamic> map) {
    return SiteLayoutSelectedModel(
      id: map['id'] as int,
      layoutId: map['layoutId'] as int,
      LayoutSelected: SiteLayoutImage.fromMap(
          map['LayoutSelected'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SiteLayoutSelectedModel.fromJson(String source) =>
      SiteLayoutSelectedModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SiteLayoutSelectedModel(id: $id,  layoutId: $layoutId, LayoutSelected: $LayoutSelected)';
  }

  @override
  bool operator ==(covariant SiteLayoutSelectedModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.layoutId == layoutId &&
        other.LayoutSelected == LayoutSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^ layoutId.hashCode ^ LayoutSelected.hashCode;
  }
}

class SiteLayoutFinishedModel {
  int id = 0;
  int layoutId = 0;
  SiteLayoutImage LayoutFinished;
  SiteLayoutFinishedModel({
    required this.id,
    required this.layoutId,
    required this.LayoutFinished,
  });

  SiteLayoutFinishedModel copyWith({
    int? id,
    int? layoutId,
    SiteLayoutImage? LayoutFinished,
  }) {
    return SiteLayoutFinishedModel(
      id: id ?? this.id,
      layoutId: layoutId ?? this.layoutId,
      LayoutFinished: LayoutFinished ?? this.LayoutFinished,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'layoutId': layoutId,
      'LayoutFinished': LayoutFinished.toMap(),
    };
  }

  factory SiteLayoutFinishedModel.fromMap(Map<String, dynamic> map) {
    return SiteLayoutFinishedModel(
      id: map['id'] as int,
      layoutId: map['layoutId'] as int,
      LayoutFinished:
          SiteLayoutImage.fromMap(map['LayoutFinshed'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SiteLayoutFinishedModel.fromJson(String source) =>
      SiteLayoutFinishedModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SiteLayoutFinishedModel(id: $id,  layoutId: $layoutId, LayoutFinished: $LayoutFinished)';
  }

  @override
  bool operator ==(covariant SiteLayoutFinishedModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.layoutId == layoutId &&
        other.LayoutFinished == LayoutFinished;
  }

  @override
  int get hashCode {
    return id.hashCode ^ layoutId.hashCode ^ LayoutFinished.hashCode;
  }
}

class SiteLayoutImage {
  int id = 0;
  String url = "";
  String title = "";
  String author = "";
  SiteLayoutImage({
    required this.id,
    required this.url,
    required this.title,
    required this.author,
  });

  SiteLayoutImage copyWith({
    int? id,
    String? url,
    String? title,
    String? author,
  }) {
    return SiteLayoutImage(
      id: id ?? this.id,
      url: url ?? this.url,
      title: title ?? this.title,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'title': title,
      'author': author,
    };
  }

  factory SiteLayoutImage.fromMap(Map<String, dynamic> map) {
    return SiteLayoutImage(
      id: map['id'] as int,
      url: map['url'] as String,
      title: map['title'] as String,
      author: map['author'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SiteLayoutImage.fromJson(String source) =>
      SiteLayoutImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SiteLayoutImage(id: $id, url: $url, title: $title, author: $author)';
  }

  @override
  bool operator ==(covariant SiteLayoutImage other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.url == url &&
        other.title == title &&
        other.author == author;
  }

  @override
  int get hashCode {
    return id.hashCode ^ url.hashCode ^ title.hashCode ^ author.hashCode;
  }
}
