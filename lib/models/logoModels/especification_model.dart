import 'dart:convert';

class EspecificationModel {
  String text = "";
  String value = "";
  bool isSelected = false;
  EspecificationModel({
    required this.text,
    required this.value,
    required this.isSelected,
  });

  EspecificationModel copyWith({
    String? text,
    String? value,
    bool? isSelected,
  }) {
    return EspecificationModel(
      text: text ?? this.text,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'value': value,
      'isSelected': isSelected,
    };
  }

  factory EspecificationModel.fromMap(Map<String, dynamic> map) {
    return EspecificationModel(
      text: map['text'] as String,
      value: map['value'] as String,
      isSelected: map['isSelected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory EspecificationModel.fromJson(String source) =>
      EspecificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'EspecificationModel(text: $text, value: $value, isSelected: $isSelected)';

  @override
  bool operator ==(covariant EspecificationModel other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.value == value &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode => text.hashCode ^ value.hashCode ^ isSelected.hashCode;
}
