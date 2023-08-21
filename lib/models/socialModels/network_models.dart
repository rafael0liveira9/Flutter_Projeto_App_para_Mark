// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NetworkTypeModel {
  String name = "";
  String value = "";
  bool isSelected = false;
  NetworkTypeModel({
    required this.name,
    required this.value,
  });

  NetworkTypeModel copyWith({
    String? name,
    String? value,
    bool? isSelected,
  }) {
    return NetworkTypeModel(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'isSelected': isSelected,
    };
  }

  factory NetworkTypeModel.fromMap(Map<String, dynamic> map) {
    return NetworkTypeModel(
      name: map['name'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NetworkTypeModel.fromJson(String source) =>
      NetworkTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NetworkTypeModel(name: $name, value: $value, isSelected: $isSelected)';

  @override
  bool operator ==(covariant NetworkTypeModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.value == value &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode ^ isSelected.hashCode;
}
