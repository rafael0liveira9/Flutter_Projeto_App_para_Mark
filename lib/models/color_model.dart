// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class ColorModel {
  Color color;
  String name = "";
  bool isSelected = false;

  ColorModel({
    required this.color,
    required this.name,
    required this.isSelected,
  });

  ColorModel copyWith({
    Color? color,
    String? name,
    bool? isSelected,
  }) {
    return ColorModel(
      color: color ?? this.color,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'color': color.value,
      'name': name,
      'isSelected': isSelected,
    };
  }

  factory ColorModel.fromMap(Map<String, dynamic> map) {
    return ColorModel(
      color: Color(map['color'] as int),
      name: map['name'] as String,
      isSelected: map['isSelected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorModel.fromJson(String source) =>
      ColorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ColorModel(color: $color, name: $name, isSelected: $isSelected)';

  @override
  bool operator ==(covariant ColorModel other) {
    if (identical(this, other)) return true;

    return other.color == color &&
        other.name == name &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode => color.hashCode ^ name.hashCode ^ isSelected.hashCode;
}
