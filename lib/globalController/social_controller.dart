// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:get/get.dart';

class SocialController extends GetxController {
  RxList<WeekDayOption> weekDays = <WeekDayOption>[
    WeekDayOption(day: "Segunda-Feira"),
    WeekDayOption(day: "Terça-Feira"),
    WeekDayOption(day: "Quarta-Feira"),
    WeekDayOption(day: "Quinta-Feira"),
    WeekDayOption(day: "Sexta-Feira"),
    WeekDayOption(day: "Sábado"),
    WeekDayOption(day: "Domingo"),
  ].obs;

  RxList<MaterialFormatOption> materialFormat = <MaterialFormatOption>[
    MaterialFormatOption(
      materialFormat: "Elementos",
      value: "ELEMENT",
    ),
    MaterialFormatOption(
      materialFormat: "Fotos",
      value: "PHOTO",
    ),
    MaterialFormatOption(
      materialFormat: "Mescla",
      value: "ALL",
    ),
  ].obs;
}

class WeekDayOption {
  String day = "";
  bool isSelected = false;

  WeekDayOption({
    required this.day,
  });

  WeekDayOption copyWith({
    String? day,
  }) {
    return WeekDayOption(
      day: day ?? this.day,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
    };
  }

  factory WeekDayOption.fromMap(Map<String, dynamic> map) {
    return WeekDayOption(
      day: map['day'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeekDayOption.fromJson(String source) =>
      WeekDayOption.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WeekDayOption(day: $day, isSelected: $isSelected)';

  @override
  bool operator ==(covariant WeekDayOption other) {
    if (identical(this, other)) return true;

    return other.day == day && other.isSelected == isSelected;
  }

  @override
  int get hashCode => day.hashCode ^ isSelected.hashCode;
}

class MaterialFormatOption {
  String materialFormat = "";
  String value = "";
  bool isSelected = false;

  MaterialFormatOption({
    required this.materialFormat,
    required this.value,
  });

  MaterialFormatOption copyWith({
    String? materialFormat,
    String? value,
  }) {
    return MaterialFormatOption(
      materialFormat: materialFormat ?? this.materialFormat,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'materialFormat': materialFormat,
      'value': value,
      'isSelected': isSelected,
    };
  }

  factory MaterialFormatOption.fromMap(Map<String, dynamic> map) {
    return MaterialFormatOption(
      materialFormat: map['materialFormat'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MaterialFormatOption.fromJson(String source) =>
      MaterialFormatOption.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MaterialFormatOption(materialFormat: $materialFormat, value: $value, isSelected: $isSelected)';

  @override
  bool operator ==(covariant MaterialFormatOption other) {
    if (identical(this, other)) return true;

    return other.materialFormat == materialFormat && other.value == value;
  }

  @override
  int get hashCode =>
      materialFormat.hashCode ^ value.hashCode ^ isSelected.hashCode;
}
