// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TypographyModel {
  String fontName = "";
  bool isSelected = false;
  String type = "";
  TypographyModel({
    required this.fontName,
    required this.isSelected,
    required this.type,
  });

  TypographyModel copyWith({
    String? fontName,
    bool? isSelected,
    String? type,
  }) {
    return TypographyModel(
      fontName: fontName ?? this.fontName,
      isSelected: isSelected ?? this.isSelected,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fontName': fontName,
      'isSelected': isSelected,
      'type': type,
    };
  }

  factory TypographyModel.fromMap(Map<String, dynamic> map) {
    return TypographyModel(
      fontName: map['fontName'] as String,
      isSelected: map['isSelected'] as bool,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypographyModel.fromJson(String source) =>
      TypographyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TypographyModel(fontName: $fontName, isSelected: $isSelected, type: $type)';

  @override
  bool operator ==(covariant TypographyModel other) {
    if (identical(this, other)) return true;

    return other.fontName == fontName &&
        other.isSelected == isSelected &&
        other.type == type;
  }

  @override
  int get hashCode => fontName.hashCode ^ isSelected.hashCode ^ type.hashCode;
}
