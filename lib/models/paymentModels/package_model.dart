// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PackageModel {
  int id;
  String name;
  double price;
  String description;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? dueDate;
  DateTime? deletedAt;
  List<PackageServiceModel> PackagesServices;
  bool isSelected = false;
  PackageModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    this.dueDate,
    this.deletedAt,
    required this.PackagesServices,
  });

  PackageModel copyWith({
    int? id,
    String? name,
    double? price,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? dueDate,
    DateTime? deletedAt,
    List<PackageServiceModel>? PackagesServices,
  }) {
    return PackageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dueDate: dueDate ?? this.dueDate,
      deletedAt: deletedAt ?? this.deletedAt,
      PackagesServices: PackagesServices ?? this.PackagesServices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'deletedAt': deletedAt?.millisecondsSinceEpoch,
      'PackagesServices': PackagesServices.map((x) => x.toMap()).toList(),
    };
  }

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'].toDouble(),
      description: map['description'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
      dueDate: map['dueDate'] != null
          ? DateTime.parse(map['dueDate'] as String)
          : null,
      deletedAt: map['deletedAt'] != null
          ? DateTime.parse(map['deletedAt'] as String)
          : null,
      PackagesServices: List<PackageServiceModel>.from(
        (map['PackagesServices'] as List).map<PackageServiceModel>(
          (x) => PackageServiceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageModel.fromJson(String source) =>
      PackageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PackageModel(id: $id, name: $name, price: $price, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, dueDate: $dueDate, deletedAt: $deletedAt, PackagesServices: $PackagesServices)';
  }

  @override
  bool operator ==(covariant PackageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.dueDate == dueDate &&
        other.deletedAt == deletedAt &&
        listEquals(other.PackagesServices, PackagesServices);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        dueDate.hashCode ^
        deletedAt.hashCode ^
        PackagesServices.hashCode;
  }
}

class PackageServiceModel {
  int id;
  int packageId;
  int serviceId;
  ServiceModel Service;
  PackageServiceModel({
    required this.id,
    required this.packageId,
    required this.serviceId,
    required this.Service,
  });

  PackageServiceModel copyWith({
    int? id,
    int? packageId,
    int? serviceId,
    ServiceModel? Service,
  }) {
    return PackageServiceModel(
      id: id ?? this.id,
      packageId: packageId ?? this.packageId,
      serviceId: serviceId ?? this.serviceId,
      Service: Service ?? this.Service,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'packageId': packageId,
      'serviceId': serviceId,
      'Service': Service.toMap(),
    };
  }

  factory PackageServiceModel.fromMap(Map<String, dynamic> map) {
    return PackageServiceModel(
      id: map['id'] as int,
      packageId: map['packageId'] as int,
      serviceId: map['serviceId'] as int,
      Service: ServiceModel.fromMap(map['Service'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageServiceModel.fromJson(String source) =>
      PackageServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PackageServiceModel(id: $id, packageId: $packageId, serviceId: $serviceId, Service: $Service)';
  }

  @override
  bool operator ==(covariant PackageServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.packageId == packageId &&
        other.serviceId == serviceId &&
        other.Service == Service;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        packageId.hashCode ^
        serviceId.hashCode ^
        Service.hashCode;
  }
}

class ServiceModel {
  int id;
  String name;
  double price;
  String description;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  int serviceTypeId;
  ServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.serviceTypeId,
  });

  ServiceModel copyWith({
    int? id,
    String? name,
    double? price,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    int? serviceTypeId,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'serviceTypeId': serviceTypeId,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'].toDouble(),
      description: map['description'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
      deletedAt: map['deletedAt'] != null
          ? DateTime.parse(map['deletedAt'] as String)
          : null,
      serviceTypeId: map['serviceTypeId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServiceModel(id: $id, name: $name, price: $price, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, serviceTypeId: $serviceTypeId)';
  }

  @override
  bool operator ==(covariant ServiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt &&
        other.serviceTypeId == serviceTypeId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode ^
        serviceTypeId.hashCode;
  }
}
