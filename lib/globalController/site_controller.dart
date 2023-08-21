// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:Mark/models/color_model.dart';
import 'package:Mark/models/controllersModels/site_layout_model.dart';
import 'package:Mark/models/logoModels/styles_model.dart';
import 'package:Mark/utils/utils.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:Mark/models/contratedModels/site_contrated_item_model.dart';

class SiteController extends GetxController {
  RxList<SiteLayoutBaseControllerModel> SiteLayoutBase =
      <SiteLayoutBaseControllerModel>[].obs;

  RxList<StylesModel> stylesSelect = <StylesModel>[
    StylesModel(
      text: "Onepage",
      isSelected: false,
      val: 'ONEPAGE',
    ),
    StylesModel(
      text: "Multipage",
      isSelected: false,
      val: 'MULTIPAGE',
    ),
    StylesModel(
      text: "Landpage",
      isSelected: false,
      val: 'LANDPAGE',
    ),
    StylesModel(
      text: "Mobile First",
      isSelected: false,
      val: 'MOBILEFIRST',
    ),
    StylesModel(
      text: "Não tenho preferência",
      isSelected: false,
      val: 'NONE',
    ),
  ].obs;

  RxList<ColorModel> colorSelected = <ColorModel>[
    ColorModel(color: Colors.black, name: "Black", isSelected: false),
    ColorModel(color: Colors.black, name: "Black", isSelected: false),
    ColorModel(color: Colors.black, name: "Black", isSelected: false),
  ].obs;

  RxList<Color> colorsData = <Color>[].obs;
  RxList<String> colorsText = <String>[].obs;

  void AddSiteLayoutBase(List<SiteLayoutBaseModel> layouts) {
    SiteLayoutBase.value = [];
    SiteLayoutBase.value = List.from(layouts)
        .map((e) => SiteLayoutBaseControllerModel(layout: e))
        .toList();
    return;
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
