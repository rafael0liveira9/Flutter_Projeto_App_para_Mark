import 'dart:convert';

import 'package:flutter/material.dart';

class StylesModel {
  String text = "";
  String val = "";
  double width = 0.0;
  double height = 0.0;
  BoxShape shape = BoxShape.rectangle;
  bool isSelected = false;

  StylesModel({
    required this.text,
    required this.val,
    this.width = 0.0,
    this.height = 0.0,
    this.shape = BoxShape.rectangle,
    required this.isSelected,
  });

  StylesModel copyWith({
    String? text,
    String? val,
    double? width,
    double? height,
    BoxShape? shape,
    bool? isSelected,
  }) {
    return StylesModel(
      text: text ?? this.text,
      val: val ?? this.val,
      width: width ?? this.width,
      height: height ?? this.height,
      shape: shape ?? this.shape,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'val': val,
      'width': width,
      'height': height,
      'shape': shape,
      'isSelected': isSelected,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'StylesModel(text: $text,val: $val, width: $width, height: $height, shape: $shape, isSelected: $isSelected)';
  }

  @override
  bool operator ==(covariant StylesModel other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.val == val &&
        other.width == width &&
        other.height == height &&
        other.shape == shape &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        val.hashCode ^
        width.hashCode ^
        height.hashCode ^
        shape.hashCode ^
        isSelected.hashCode;
  }
}
