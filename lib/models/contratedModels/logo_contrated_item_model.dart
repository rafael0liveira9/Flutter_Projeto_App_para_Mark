// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class LogoContratedItem {
  int id = 0;
  int contratedServiceId = 0;
  int logoServiceId = 0;
  LogoServiceModel LogoService;

  LogoContratedItem({
    required this.id,
    required this.contratedServiceId,
    required this.logoServiceId,
    required this.LogoService,
  });

  LogoContratedItem copyWith({
    int? id,
    int? contratedServiceId,
    int? logoServiceId,
    LogoServiceModel? LogoService,
  }) {
    return LogoContratedItem(
      id: id ?? this.id,
      contratedServiceId: contratedServiceId ?? this.contratedServiceId,
      logoServiceId: logoServiceId ?? this.logoServiceId,
      LogoService: LogoService ?? this.LogoService,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'contratedServiceId': contratedServiceId,
      'logoServiceId': logoServiceId,
      'LogoService': LogoService.toMap(),
    };
  }

  factory LogoContratedItem.fromMap(Map<String, dynamic> map) {
    return LogoContratedItem(
      id: map['id'] as int,
      contratedServiceId: map['contratedServiceId'] as int,
      logoServiceId: map['logoServiceId'] as int,
      LogoService:
          LogoServiceModel.fromMap(map['LogoService'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LogoContratedItem.fromJson(String source) =>
      LogoContratedItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LogoContratedItem(id: $id, contratedServiceId: $contratedServiceId, logoServiceId: $logoServiceId, LogoService: $LogoService)';
  }

  @override
  bool operator ==(covariant LogoContratedItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.contratedServiceId == contratedServiceId &&
        other.logoServiceId == logoServiceId &&
        other.LogoService == LogoService;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        contratedServiceId.hashCode ^
        logoServiceId.hashCode ^
        LogoService.hashCode;
  }
}

class LogoServiceModel {
  int id = 0;
  int status;
  String? dueDate = "";
  bool? feedbackSended;
  int serviceTypeId = 0;
  int? logoBriefingId;
  int? logoProofId;
  int? logoFeedbackId;
  List<LogoArchivesModel> LogoArchives;
  LogoProofModel? LogoProof;
  LogoBriefingModel? LogoBriefing;

  LogoServiceModel({
    required this.id,
    required this.status,
    this.dueDate,
    this.feedbackSended,
    required this.serviceTypeId,
    this.logoBriefingId,
    this.logoProofId,
    this.logoFeedbackId,
    required this.LogoArchives,
    required this.LogoProof,
    required this.LogoBriefing,
  });

  LogoServiceModel copyWith({
    int? id,
    int? status,
    String? dueDate,
    bool? feedbackSended,
    int? serviceTypeId,
    int? logoBriefingId,
    int? logoProofId,
    int? logoFeedbackId,
    List<LogoArchivesModel>? LogoArchives,
    LogoProofModel? LogoProof,
    LogoBriefingModel? LogoBriefing,
  }) {
    return LogoServiceModel(
      id: id ?? this.id,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      feedbackSended: feedbackSended ?? this.feedbackSended,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      logoBriefingId: logoBriefingId ?? this.logoBriefingId,
      logoProofId: logoProofId ?? this.logoProofId,
      logoFeedbackId: logoFeedbackId ?? this.logoFeedbackId,
      LogoArchives: LogoArchives ?? this.LogoArchives,
      LogoProof: LogoProof ?? this.LogoProof,
      LogoBriefing: LogoBriefing ?? this.LogoBriefing,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'dueDate': dueDate,
      'feedbackSended': feedbackSended,
      'serviceTypeId': serviceTypeId,
      'logoBriefingId': logoBriefingId,
      'logoProofId': logoProofId,
      'logoFeedbackId': logoFeedbackId,
      'LogoArchives': LogoArchives.map((x) => x.toMap()).toList(),
      'LogoProof': LogoProof?.toMap(),
      'LogoBriefing': LogoBriefing?.toMap(),
    };
  }

  factory LogoServiceModel.fromMap(Map<String, dynamic> map) {
    return LogoServiceModel(
      id: map['id'] as int,
      status: map['status'] as int,
      dueDate: map['dueDate'] != null ? map['dueDate'] as String : null,
      feedbackSended:
          map['feedbackSended'] != null ? map['feedbackSended'] as bool : null,
      serviceTypeId: map['serviceTypeId'] as int,
      logoBriefingId:
          map['logoBriefingId'] != null ? map['logoBriefingId'] as int : null,
      logoProofId:
          map['logoProofId'] != null ? map['logoProofId'] as int : null,
      logoFeedbackId:
          map['logoFeedbackId'] != null ? map['logoFeedbackId'] as int : null,
      LogoArchives: List<LogoArchivesModel>.from(
        (map['LogoArchives'] as List).map<LogoArchivesModel>(
          (x) => LogoArchivesModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      LogoProof: map['LogoProof'] != null
          ? LogoProofModel.fromMap(map['LogoProof'] as Map<String, dynamic>)
          : null,
      LogoBriefing: map['LogoBriefing'] != null
          ? LogoBriefingModel.fromMap(
              map['LogoBriefing'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogoServiceModel.fromJson(String source) =>
      LogoServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LogoServiceModel(id: $id, status: $status, dueDate: $dueDate, feedbackSended: $feedbackSended, serviceTypeId: $serviceTypeId, logoBriefingId: $logoBriefingId, logoProofId: $logoProofId, logoFeedbackId: $logoFeedbackId, LogoArchives: $LogoArchives, LogoProof: $LogoProof, LogoBriefing: $LogoBriefing)';
  }

  @override
  bool operator ==(covariant LogoServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.status == status &&
        other.dueDate == dueDate &&
        other.feedbackSended == feedbackSended &&
        other.serviceTypeId == serviceTypeId &&
        other.logoBriefingId == logoBriefingId &&
        other.logoProofId == logoProofId &&
        other.logoFeedbackId == logoFeedbackId &&
        listEquals(other.LogoArchives, LogoArchives) &&
        other.LogoProof == LogoProof &&
        other.LogoBriefing == LogoBriefing;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        dueDate.hashCode ^
        feedbackSended.hashCode ^
        serviceTypeId.hashCode ^
        logoBriefingId.hashCode ^
        logoProofId.hashCode ^
        logoFeedbackId.hashCode ^
        LogoArchives.hashCode ^
        LogoProof.hashCode ^
        LogoBriefing.hashCode;
  }
}

class LogoArchivesModel {
  int id = 0;
  String name = "";
  String type = "";
  String url = "";
  int previewId = 0;
  LogoArchivesPreviewModel preview;
  LogoArchivesModel({
    required this.id,
    required this.name,
    required this.type,
    required this.url,
    required this.previewId,
    required this.preview,
  });

  LogoArchivesModel copyWith({
    int? id,
    String? name,
    String? type,
    String? url,
    int? previewId,
    LogoArchivesPreviewModel? preview,
  }) {
    return LogoArchivesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      url: url ?? this.url,
      previewId: previewId ?? this.previewId,
      preview: preview ?? this.preview,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'url': url,
      'previewId': previewId,
      'preview': preview.toMap(),
    };
  }

  factory LogoArchivesModel.fromMap(Map<String, dynamic> map) {
    return LogoArchivesModel(
      id: map['id'] as int,
      name: map['name'] as String,
      type: map['type'] as String,
      url: map['url'] as String,
      previewId: map['previewId'] as int,
      preview: LogoArchivesPreviewModel.fromMap(
          map['preview'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LogoArchivesModel.fromJson(String source) =>
      LogoArchivesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LogoArchivesModel(id: $id, name: $name, type: $type, url: $url, previewId: $previewId, preview: $preview)';
  }

  @override
  bool operator ==(covariant LogoArchivesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.type == type &&
        other.url == url &&
        other.previewId == previewId &&
        other.preview == preview;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        url.hashCode ^
        previewId.hashCode ^
        preview.hashCode;
  }
}

class LogoArchivesPreviewModel {
  int id = 0;
  String url = "";
  String title = "";
  String author = "";
  LogoArchivesPreviewModel({
    required this.id,
    required this.url,
    required this.title,
    required this.author,
  });

  LogoArchivesPreviewModel copyWith({
    int? id,
    String? url,
    String? title,
    String? author,
  }) {
    return LogoArchivesPreviewModel(
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

  factory LogoArchivesPreviewModel.fromMap(Map<String, dynamic> map) {
    return LogoArchivesPreviewModel(
      id: map['id'] as int,
      url: map['url'] as String,
      title: map['title'] as String,
      author: map['author'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogoArchivesPreviewModel.fromJson(String source) =>
      LogoArchivesPreviewModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LogoArchivesPreviewModel(id: $id, url: $url, title: $title, author: $author)';
  }

  @override
  bool operator ==(covariant LogoArchivesPreviewModel other) {
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

class LogoBriefingModel {
  int id = 0;
  String format = "";
  List<String> cores;
  String typography = "";
  String especification = "";
  String description = "";
  String references = "";
  LogoBriefingModel({
    required this.id,
    required this.format,
    required this.cores,
    required this.typography,
    required this.especification,
    required this.description,
    required this.references,
  });

  LogoBriefingModel copyWith({
    int? id,
    String? format,
    List<String>? cores,
    String? typography,
    String? especification,
    String? description,
    String? references,
  }) {
    return LogoBriefingModel(
      id: id ?? this.id,
      format: format ?? this.format,
      cores: cores ?? this.cores,
      typography: typography ?? this.typography,
      especification: especification ?? this.especification,
      description: description ?? this.description,
      references: references ?? this.references,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'format': format,
      'cores': cores,
      'typography': typography,
      'especification': especification,
      'description': description,
      'references': references,
    };
  }

  factory LogoBriefingModel.fromMap(Map<String, dynamic> map) {
    return LogoBriefingModel(
      id: map['id'] as int,
      format: map['format'] as String,
      cores: List<String>.from((map['cores'] as List)),
      typography: map['typography'] as String,
      especification: map['especification'] as String,
      description: map['description'] as String,
      references: map['references'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogoBriefingModel.fromJson(String source) =>
      LogoBriefingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LogoBriefingModel(id: $id, format: $format, cores: $cores, typography: $typography, especification: $especification, description: $description, references: $references, )';
  }

  @override
  bool operator ==(covariant LogoBriefingModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.format == format &&
        listEquals(other.cores, cores) &&
        other.typography == typography &&
        other.especification == especification &&
        other.description == description &&
        other.references == references;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        format.hashCode ^
        cores.hashCode ^
        typography.hashCode ^
        especification.hashCode ^
        description.hashCode ^
        references.hashCode;
  }
}

class LogoFeedbackModel {
  int id = 0;
  int stars = 0;
  String comments = "";
}

class LogoProofModel {
  int id = 0;
  bool? isApproved;
  bool? userSended;
  String? reasonRefuse;
  LogoArchivesPreviewModel proofImage;
  List<LogoProofMockupsModel> Mockups;

  LogoProofModel({
    required this.id,
    this.isApproved,
    this.userSended,
    this.reasonRefuse,
    required this.proofImage,
    required this.Mockups,
  });

  LogoProofModel copyWith({
    int? id,
    bool? isApproved,
    bool? userSended,
    String? reasonRefuse,
    LogoArchivesPreviewModel? proofImage,
    List<LogoProofMockupsModel>? Mockups,
  }) {
    return LogoProofModel(
      id: id ?? this.id,
      isApproved: isApproved ?? this.isApproved,
      userSended: userSended ?? this.userSended,
      reasonRefuse: reasonRefuse ?? this.reasonRefuse,
      proofImage: proofImage ?? this.proofImage,
      Mockups: Mockups ?? this.Mockups,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isApproved': isApproved,
      'userSended': userSended,
      'reasonRefuse': reasonRefuse,
      'proofImage': proofImage.toMap(),
      'Mockups': Mockups.map((x) => x.toMap()).toList(),
    };
  }

  factory LogoProofModel.fromMap(Map<String, dynamic> map) {
    return LogoProofModel(
      id: map['id'] as int,
      isApproved: map['isApproved'] != null ? map['isApproved'] as bool : null,
      userSended: map['userSended'] != null ? map['userSended'] as bool : null,
      reasonRefuse:
          map['reasonRefuse'] != null ? map['reasonRefuse'] as String : null,
      proofImage: LogoArchivesPreviewModel.fromMap(
          map['proofImage'] as Map<String, dynamic>),
      Mockups: List<LogoProofMockupsModel>.from(
        (map['Mockups'] as List).map<LogoProofMockupsModel>(
          (x) => LogoProofMockupsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LogoProofModel.fromJson(String source) =>
      LogoProofModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LogoProofModel(id: $id, isApproved: $isApproved, userSended: $userSended, reasonRefuse: $reasonRefuse, proofImage: $proofImage, Mockups: $Mockups)';
  }

  @override
  bool operator ==(covariant LogoProofModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.isApproved == isApproved &&
        other.userSended == userSended &&
        other.reasonRefuse == reasonRefuse &&
        other.proofImage == proofImage &&
        listEquals(other.Mockups, Mockups);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        isApproved.hashCode ^
        userSended.hashCode ^
        reasonRefuse.hashCode ^
        proofImage.hashCode ^
        Mockups.hashCode;
  }
}

class LogoProofMockupsModel {
  int id = 0;
  int imagesId = 0;
  LogoArchivesPreviewModel image;
  LogoProofMockupsModel({
    required this.id,
    required this.imagesId,
    required this.image,
  });

  LogoProofMockupsModel copyWith({
    int? id,
    int? imagesId,
    LogoArchivesPreviewModel? image,
  }) {
    return LogoProofMockupsModel(
      id: id ?? this.id,
      imagesId: imagesId ?? this.imagesId,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imagesId': imagesId,
      'image': image.toMap(),
    };
  }

  factory LogoProofMockupsModel.fromMap(Map<String, dynamic> map) {
    return LogoProofMockupsModel(
      id: map['id'] as int,
      imagesId: map['imagesId'] as int,
      image: LogoArchivesPreviewModel.fromMap(
          map['image'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LogoProofMockupsModel.fromJson(String source) =>
      LogoProofMockupsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LogoProofMockupsModel(id: $id, imagesId: $imagesId, image: $image)';

  @override
  bool operator ==(covariant LogoProofMockupsModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.imagesId == imagesId && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ imagesId.hashCode ^ image.hashCode;
}
