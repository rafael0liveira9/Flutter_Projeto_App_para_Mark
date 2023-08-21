// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SocialContratedItem {
  int id = 0;
  int contratedServiceId = 0;
  int socialServiceId = 0;
  SocialServiceModel SocialService;
  SocialContratedItem({
    required this.id,
    required this.contratedServiceId,
    required this.socialServiceId,
    required this.SocialService,
  });

  SocialContratedItem copyWith({
    int? id,
    int? contratedServiceId,
    int? socialServiceId,
    SocialServiceModel? SocialService,
  }) {
    return SocialContratedItem(
      id: id ?? this.id,
      contratedServiceId: contratedServiceId ?? this.contratedServiceId,
      socialServiceId: socialServiceId ?? this.socialServiceId,
      SocialService: SocialService ?? this.SocialService,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'contratedServiceId': contratedServiceId,
      'socialServiceId': socialServiceId,
      'SocialService': SocialService.toMap(),
    };
  }

  factory SocialContratedItem.fromMap(Map<String, dynamic> map) {
    return SocialContratedItem(
      id: map['id'] as int,
      contratedServiceId: map['contratedServiceId'] as int,
      socialServiceId: map['socialServiceId'] as int,
      SocialService: SocialServiceModel.fromMap(
          map['SocialService'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialContratedItem.fromJson(String source) =>
      SocialContratedItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SocialContratedItem(id: $id, contratedServiceId: $contratedServiceId, socialServiceId: $socialServiceId, SocialService: $SocialService)';
  }

  @override
  bool operator ==(covariant SocialContratedItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.contratedServiceId == contratedServiceId &&
        other.socialServiceId == socialServiceId &&
        other.SocialService == SocialService;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        contratedServiceId.hashCode ^
        socialServiceId.hashCode ^
        SocialService.hashCode;
  }
}

class SocialServiceModel {
  int id = 0;
  int status;
  String? dueDate = "";
  int serviceTypeId = 0;
  int? socialShowId;
  int? socialBriefingId;
  SocialBriefingModel? SocialBriefing;
  SocialShowModel? SocialShow;

  SocialServiceModel({
    required this.id,
    required this.status,
    this.dueDate,
    required this.serviceTypeId,
    this.socialShowId,
    this.socialBriefingId,
    this.SocialBriefing,
    this.SocialShow,
  });

  SocialServiceModel copyWith({
    int? id,
    int? status,
    String? dueDate,
    int? serviceTypeId,
    int? socialShowId,
    int? socialBriefingId,
    SocialBriefingModel? SocialBriefing,
    SocialShowModel? SocialShow,
  }) {
    return SocialServiceModel(
      id: id ?? this.id,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      socialShowId: socialShowId ?? this.socialShowId,
      socialBriefingId: socialBriefingId ?? this.socialBriefingId,
      SocialBriefing: SocialBriefing ?? this.SocialBriefing,
      SocialShow: SocialShow ?? this.SocialShow,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'dueDate': dueDate,
      'serviceTypeId': serviceTypeId,
      'socialShowId': socialShowId,
      'socialBriefingId': socialBriefingId,
      'SocialBriefing': SocialBriefing?.toMap(),
      'SocialShow': SocialShow?.toMap(),
    };
  }

  factory SocialServiceModel.fromMap(Map<String, dynamic> map) {
    return SocialServiceModel(
      id: map['id'] as int,
      status: map['status'] as int,
      dueDate: map['dueDate'] != null ? map['dueDate'] as String : null,
      serviceTypeId: map['serviceTypeId'] as int,
      socialShowId:
          map['socialShowId'] != null ? map['socialShowId'] as int : null,
      socialBriefingId: map['socialBriefingId'] != null
          ? map['socialBriefingId'] as int
          : null,
      SocialBriefing: map['SocialBriefing'] != null
          ? SocialBriefingModel.fromMap(
              map['SocialBriefing'] as Map<String, dynamic>)
          : null,
      SocialShow: map['SocialShow'] != null
          ? SocialShowModel.fromMap(map['SocialShow'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialServiceModel.fromJson(String source) =>
      SocialServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SocialServiceModel(id: $id, status: $status, dueDate: $dueDate, serviceTypeId: $serviceTypeId, socialShowId: $socialShowId, socialBriefingId: $socialBriefingId, SocialBriefing: $SocialBriefing, SocialShow: $SocialShow)';
  }

  @override
  bool operator ==(covariant SocialServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.status == status &&
        other.dueDate == dueDate &&
        other.serviceTypeId == serviceTypeId &&
        other.socialShowId == socialShowId &&
        other.socialBriefingId == socialBriefingId &&
        other.SocialBriefing == SocialBriefing &&
        other.SocialShow == SocialShow;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        dueDate.hashCode ^
        serviceTypeId.hashCode ^
        socialShowId.hashCode ^
        socialBriefingId.hashCode ^
        SocialBriefing.hashCode ^
        SocialShow.hashCode;
  }
}

class SocialBriefingModel {
  int id = 0;
  String networkType = "";
  String serviceType = "";
  String imageBase = "";
  String materialQuant = "";
  String dayHours = "";
  String mediaFormat = "";
  SocialBriefingModel({
    required this.id,
    required this.networkType,
    required this.serviceType,
    required this.imageBase,
    required this.materialQuant,
    required this.dayHours,
    required this.mediaFormat,
  });

  SocialBriefingModel copyWith({
    int? id,
    String? networkType,
    String? serviceType,
    String? imageBase,
    String? materialQuant,
    String? dayHours,
    String? mediaFormat,
  }) {
    return SocialBriefingModel(
      id: id ?? this.id,
      networkType: networkType ?? this.networkType,
      serviceType: serviceType ?? this.serviceType,
      imageBase: imageBase ?? this.imageBase,
      materialQuant: materialQuant ?? this.materialQuant,
      dayHours: dayHours ?? this.dayHours,
      mediaFormat: mediaFormat ?? this.mediaFormat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'networkType': networkType,
      'serviceType': serviceType,
      'imageBase': imageBase,
      'materialQuant': materialQuant,
      'dayHours': dayHours,
      'mediaFormat': mediaFormat,
    };
  }

  factory SocialBriefingModel.fromMap(Map<String, dynamic> map) {
    return SocialBriefingModel(
      id: map['id'] as int,
      networkType: map['networkType'] as String,
      serviceType: map['serviceType'] as String,
      imageBase: map['imageBase'] as String,
      materialQuant: map['materialQuant'] as String,
      dayHours: map['daysHours'] as String,
      mediaFormat: map['mediaFormat'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialBriefingModel.fromJson(String source) =>
      SocialBriefingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SocialBriefingModel(id: $id, networkType: $networkType, serviceType: $serviceType, imageBase: $imageBase, materialQuant: $materialQuant, dayHours: $dayHours, mediaFormat: $mediaFormat)';
  }

  @override
  bool operator ==(covariant SocialBriefingModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.networkType == networkType &&
        other.serviceType == serviceType &&
        other.imageBase == imageBase &&
        other.materialQuant == materialQuant &&
        other.dayHours == dayHours &&
        other.mediaFormat == mediaFormat;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        networkType.hashCode ^
        serviceType.hashCode ^
        imageBase.hashCode ^
        materialQuant.hashCode ^
        dayHours.hashCode ^
        mediaFormat.hashCode;
  }
}

class SocialShowModel {
  int id = 0;
  bool allApproved = false;
  bool isSendedByClient = false;
  bool isRefused = false;
  List<SocialFeedModel> feed;
  SocialShowModel({
    required this.id,
    required this.allApproved,
    required this.isSendedByClient,
    required this.isRefused,
    required this.feed,
  });

  SocialShowModel copyWith({
    int? id,
    bool? allApproved,
    bool? isSendedByClient,
    bool? isRefused,
    List<SocialFeedModel>? feed,
  }) {
    return SocialShowModel(
      id: id ?? this.id,
      allApproved: allApproved ?? this.allApproved,
      isSendedByClient: isSendedByClient ?? this.isSendedByClient,
      isRefused: isRefused ?? this.isRefused,
      feed: feed ?? this.feed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'allApproved': allApproved,
      'isSendedByClient': isSendedByClient,
      'isRefused': isRefused,
      'feed': feed.map((x) => x.toMap()).toList(),
    };
  }

  factory SocialShowModel.fromMap(Map<String, dynamic> map) {
    return SocialShowModel(
      id: map['id'] as int,
      allApproved: map['allApproved'] as bool,
      isSendedByClient: map['isSendedByClient'] as bool,
      isRefused: map['isRefused'] as bool,
      feed: List<SocialFeedModel>.from(
        (map['feed'] as List).map<SocialFeedModel>(
          (x) => SocialFeedModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialShowModel.fromJson(String source) =>
      SocialShowModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SocialShowModel(id: $id, allApproved: $allApproved, isSendedByClient: $isSendedByClient, isRefused: $isRefused, feed: $feed)';
  }

  @override
  bool operator ==(covariant SocialShowModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.allApproved == allApproved &&
        other.isSendedByClient == isSendedByClient &&
        other.isRefused == isRefused &&
        listEquals(other.feed, feed);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        allApproved.hashCode ^
        isSendedByClient.hashCode ^
        isRefused.hashCode ^
        feed.hashCode;
  }
}

class SocialFeedModel {
  int id = 0;
  String text = "";
  String type = "";
  int? imagesId;
  bool? approved;
  String? reasonRefuse;
  SocialFeedImageModel? Images;

  SocialFeedModel({
    required this.id,
    required this.text,
    required this.type,
    this.imagesId,
    this.approved,
    this.reasonRefuse,
    this.Images,
  });

  SocialFeedModel copyWith({
    int? id,
    String? text,
    String? type,
    int? imagesId,
    bool? approved,
    String? reasonRefuse,
    SocialFeedImageModel? Images,
  }) {
    return SocialFeedModel(
      id: id ?? this.id,
      text: text ?? this.text,
      type: type ?? this.type,
      imagesId: imagesId ?? this.imagesId,
      approved: approved ?? this.approved,
      reasonRefuse: reasonRefuse ?? this.reasonRefuse,
      Images: Images ?? this.Images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'type': type,
      'imagesId': imagesId,
      'approved': approved,
      'reasonRefuse': reasonRefuse,
      'Images': Images?.toMap(),
    };
  }

  factory SocialFeedModel.fromMap(Map<String, dynamic> map) {
    return SocialFeedModel(
      id: map['id'] as int,
      text: map['text'] as String,
      type: map['type'] as String,
      imagesId: map['imagesId'] != null ? map['imagesId'] as int : null,
      approved: map['approved'] != null ? map['approved'] as bool : null,
      reasonRefuse:
          map['reasonRefuse'] != null ? map['reasonRefuse'] as String : null,
      Images: map['Images'] != null
          ? SocialFeedImageModel.fromMap(map['Images'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialFeedModel.fromJson(String source) =>
      SocialFeedModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SocialFeedModel(id: $id, text: $text, type: $type, imagesId: $imagesId, approved: $approved, reasonRefuse: $reasonRefuse, Images: $Images)';
  }

  @override
  bool operator ==(covariant SocialFeedModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.text == text &&
        other.type == type &&
        other.imagesId == imagesId &&
        other.approved == approved &&
        other.reasonRefuse == reasonRefuse &&
        other.Images == Images;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        type.hashCode ^
        imagesId.hashCode ^
        approved.hashCode ^
        reasonRefuse.hashCode ^
        Images.hashCode;
  }
}

class SocialFeedImageModel {
  int id = 0;
  String url = "";
  String title = "";
  String author = "";

  SocialFeedImageModel({
    required this.id,
    required this.url,
    required this.title,
    required this.author,
  });

  SocialFeedImageModel copyWith({
    int? id,
    String? url,
    String? title,
    String? author,
  }) {
    return SocialFeedImageModel(
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

  factory SocialFeedImageModel.fromMap(Map<String, dynamic> map) {
    return SocialFeedImageModel(
      id: map['id'] as int,
      url: map['url'] as String,
      title: map['title'] as String,
      author: map['author'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialFeedImageModel.fromJson(String source) =>
      SocialFeedImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SocialFeedImageModel(id: $id, url: $url, title: $title, author: $author)';
  }

  @override
  bool operator ==(covariant SocialFeedImageModel other) {
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
