// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/models/color_model.dart';
import 'package:Mark/models/logoModels/especification_model.dart';
import 'package:Mark/models/logoModels/styles_model.dart';
import 'package:Mark/models/logoModels/typography_model.dart';
import 'package:Mark/utils/utils.dart';

class LogoController extends GetxController {
  RxList<StylesModel> stylesSelect = <StylesModel>[
    StylesModel(
      text: "Quadrada",
      width: 60,
      height: 60,
      shape: BoxShape.rectangle,
      isSelected: false,
      val: 'QUADRADA',
    ),
    StylesModel(
      text: "Redonda",
      width: 60,
      height: 60,
      shape: BoxShape.circle,
      isSelected: false,
      val: 'REDONDA',
    ),
    StylesModel(
      text: "Retangular - Horizontal",
      width: 60,
      height: 40,
      shape: BoxShape.rectangle,
      isSelected: false,
      val: 'RETANGULAR_HORIZONTAL',
    ),
    StylesModel(
      text: "Retangular - Vertical",
      width: 40,
      height: 60,
      shape: BoxShape.rectangle,
      isSelected: false,
      val: 'RETANGULAR_VERTICAL',
    ),
  ].obs;

  RxList<EspecificationModel> especficationSelect = <EspecificationModel>[
    EspecificationModel(text: "Empresa", value: "EMPRESA", isSelected: false),
    EspecificationModel(text: "Produto", value: "PRODUTO", isSelected: false),
    EspecificationModel(text: "Serviço", value: "SERVICO", isSelected: false),
  ].obs;

  RxList<TypographyModel> typographyList = <TypographyModel>[
    TypographyModel(
        fontName: GoogleFonts.sourceSerifPro().fontFamily!,
        isSelected: false,
        type: "Serifa"),
    TypographyModel(
        fontName: GoogleFonts.roboto().fontFamily!,
        isSelected: false,
        type: "San-Serifa"),
    TypographyModel(
        fontName: GoogleFonts.marckScript().fontFamily!,
        isSelected: false,
        type: "Cursiva"),
    TypographyModel(
        fontName: GoogleFonts.marckScript().fontFamily!,
        isSelected: false,
        type: "Cursiva"),
  ].obs;

  final Rx<StylesModel>? styleSelected = StylesModel(
    text: "",
    val: "",
    width: 0,
    height: 0,
    shape: BoxShape.rectangle,
    isSelected: true,
  ).obs;

  RxList<ColorModel> colorSelected = <ColorModel>[
    ColorModel(color: Colors.black, name: "Black", isSelected: false),
    ColorModel(color: Colors.black, name: "Black", isSelected: false),
    ColorModel(color: Colors.black, name: "Black", isSelected: false),
  ].obs;

  RxList<Color> colorsData = <Color>[].obs;
  RxList<String> colorsText = <String>[].obs;

  final Rx<EspecificationModel>? especificationSelected = EspecificationModel(
    text: "",
    value: "",
    isSelected: true,
  ).obs;

  Rx<TypographyModel> typographySelected = TypographyModel(
    fontName: "",
    isSelected: false,
    type: "",
  ).obs;

  void setStyleSelected(int index) {
    for (var i = 0; i < stylesSelect.length; i++) {
      stylesSelect[i].isSelected = false;
    }
    stylesSelect[index].isSelected = true;
    styleSelected!.value = stylesSelect[index];
  }

  void setTypographySelected(int index) {
    for (var i = 0; i < typographyList.length; i++) {
      typographyList[i].isSelected = false;
    }
    typographyList[index].isSelected = true;
    typographySelected.value = typographyList[index];
  }

  void clearTypography() {
    for (var i = 0; i < typographyList.length; i++) {
      typographyList[i].isSelected = false;
    }
    typographySelected.value = TypographyModel(
      fontName: "",
      isSelected: false,
      type: "",
    );
  }

  void clearStyles() {
    for (var i = 0; i < stylesSelect.length; i++) {
      stylesSelect[i].isSelected = false;
    }
    styleSelected!.value = StylesModel(
      text: "",
      width: 0,
      height: 0,
      shape: BoxShape.rectangle,
      isSelected: true,
      val: '',
    );
  }

  void setEspecificationSelected(int index) {
    for (var i = 0; i < especficationSelect.length; i++) {
      especficationSelect[i].isSelected = false;
    }
    especficationSelect[index].isSelected = true;
    especificationSelected!.value = especficationSelect[index];
  }

  void clearEspecification() {
    for (var i = 0; i < especficationSelect.length; i++) {
      especficationSelect[i].isSelected = false;
    }
    especificationSelected!.value = EspecificationModel(
      text: "",
      isSelected: true,
      value: '',
    );
  }

  void clearColors() {
    colorSelected.value = [
      ColorModel(color: Colors.black, name: "Black", isSelected: false),
      ColorModel(color: Colors.black, name: "Black", isSelected: false),
      ColorModel(color: Colors.black, name: "Black", isSelected: false),
    ];
    colorsText.value = [];
  }

  void changeColors(int index, Color color) {
    colorSelected[index].color = color;
  }

  void addColorsText(int index) {
    if (colorsText.length < 3) {
      if (!colorsText.contains(
          colorNames[ColorTools.nameThatColor(colorSelected[index].color)])) {
        colorsText.add(
            "${colorNames[ColorTools.nameThatColor(colorSelected[index].color)]}");
      } else {
        colorsText.remove(
            "${colorNames[ColorTools.nameThatColor(colorSelected[index].color)]}");
      }
    } else {
      colorsText[index] =
          "${colorNames[ColorTools.nameThatColor(colorSelected[index].color)]}";
    }
  }
}
