import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/config/repo/logo_repo.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/logo_controller.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/pages/home/view/home_page.dart';

class LogoBrienfingPage extends StatefulWidget {
  const LogoBrienfingPage({super.key});

  @override
  State<LogoBrienfingPage> createState() => _LogoBrienfingPageState();
}

class _LogoBrienfingPageState extends State<LogoBrienfingPage> {
  bool isFinished = false, isLoading = false;

  final logoController = Get.put<LogoController>(LogoController());
  final serviceController = Get.put<ServiceController>(ServiceController());
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  TextEditingController format = TextEditingController();
  TextEditingController colors = TextEditingController();
  TextEditingController especification = TextEditingController();
  TextEditingController typography = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController references = TextEditingController();

  Color screenPickerColor = Colors.blue;
  Color dialogPickerColor = Colors.red;
  Color dialogSelectColor = const Color(0xFFA239CA);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightWhite,
        leadingWidth: 130,
        leading: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(
                right: 10,
              ),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: neutralTen,
                ),
              ),
            ),
            Text(
              "Logo",
              style: GoogleFonts.roboto(
                fontSize: 22,
                color: neutralTen,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            width: 100,
            margin: const EdgeInsets.only(
              right: 10,
            ),
            child: InkWell(
              onTap: () async {
                if (!isLoading) {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    Response response = await LogoRepo.sendBriefing(
                      serviceController.companieId.value,
                      serviceController.serviceId.value,
                      title.text,
                      subtitle.text,
                      logoController.styleSelected!.value.val,
                      logoController.colorSelected
                          .map((element) => "#${element.color.hex}")
                          .toList(),
                      typography.text,
                      logoController.especificationSelected!.value.value,
                      references.text,
                      description.text,
                    );

                    setState(() {
                      isLoading = false;
                    });
                    ElegantNotification.success(
                      description: const Text(
                        "Briefing criado com sucesso!",
                      ),
                      onProgressFinished: () {
                        Get.to(const HomePage());
                      },
                    ).show(context);
                  } on DioException catch (e) {
                    print(e);
                    ElegantNotification.error(
                      description: Text("${e.response?.data}"),
                    ).show(context);
                    setState(() {
                      isLoading = false;
                    });
                    return;
                  }
                }
              },
              child: Container(
                width: 93,
                height: 30,
                decoration: BoxDecoration(
                  color: format.text.isNotEmpty &&
                          colors.text.isNotEmpty &&
                          especification.text.isNotEmpty &&
                          typography.text.isNotEmpty &&
                          description.text.isNotEmpty &&
                          references.text.isNotEmpty &&
                          references.text.split(",").length >= 3
                      ? mainSecondayColor
                      : const Color(0xFf1f1f1f).withOpacity(
                          0.12,
                        ),
                  borderRadius: BorderRadius.circular(
                    100,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  isLoading ? "SALVANDO..." : "SALVAR",
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: format.text.isNotEmpty &&
                            colors.text.isNotEmpty &&
                            especification.text.isNotEmpty &&
                            typography.text.isNotEmpty &&
                            description.text.isNotEmpty &&
                            references.text.isNotEmpty &&
                            references.text.split(",").length > 2
                        ? Colors.white
                        : neutralTen.withOpacity(0.38),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Briefing",
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: neutralTen,
                  ),
                ),
              ),
              Text(
                "O “briefing” é uma coleta de informações inicial que irá auxiliar a execução do projeto dentro da proposta desejada. Selecione e preencha as informações de acordo com a linha que você gostaria que sua logo seguisse:",
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: neutralFourty,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    cursorColor: mainPrimaryColor,
                    controller: title,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      fillColor: mainPrimaryColor.withOpacity(0.11),
                      filled: true,
                      suffixIcon: title.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: neutralTen,
                              ),
                              onPressed: () {
                                setState(() {
                                  title.text = "";
                                });
                              },
                            )
                          : null,
                      labelStyle: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: neutralThree,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      labelText: "Título",
                      helperText: "Preciso de texto aqui",
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: neutralSix,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: neutralTen,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    cursorColor: mainPrimaryColor,
                    controller: subtitle,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      fillColor: mainPrimaryColor.withOpacity(0.11),
                      filled: true,
                      suffixIcon: subtitle.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: neutralTen,
                              ),
                              onPressed: () {
                                setState(() {
                                  subtitle.text = "";
                                });
                              },
                            )
                          : null,
                      labelStyle: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: neutralThree,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      labelText: "Subtítulo",
                      helperText: "Preciso de texto aqui",
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: neutralSix,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: neutralTen,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Formato/Estilo",
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: neutralTen,
                            ),
                          ),
                        ),
                        Text(
                          "Possui alguma dimensão específica que deseja para a logo?",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: neutralFourty,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                    Animate(
                      effects: const [FadeEffect()],
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var i = 0;
                                i < logoController.stylesSelect.length;
                                i++)
                              if (logoController.stylesSelect[i].width > 0 &&
                                  logoController.stylesSelect[i].height > 0)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      logoController.setStyleSelected(i);
                                      format.value = TextEditingValue(
                                        text:
                                            logoController.stylesSelect[i].text,
                                      );
                                    });
                                  },
                                  child: Container(
                                    width: logoController.stylesSelect[i].width,
                                    height:
                                        logoController.stylesSelect[i].height,
                                    decoration: BoxDecoration(
                                      shape:
                                          logoController.stylesSelect[i].shape,
                                      color: logoController
                                              .stylesSelect[i].isSelected
                                          ? mainSecondayColor
                                          : mainPrimaryColor,
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Cores",
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: neutralTen,
                            ),
                          ),
                        ),
                        Text(
                          "Existe alguma cor que não possa ficar de fora da sua logo?",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: neutralFourty,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var i = 0;
                              i < logoController.colorSelected.length;
                              i++)
                            Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await colorPickerDialog(i);
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    color:
                                        logoController.colorSelected[i].color,
                                    margin: const EdgeInsets.only(bottom: 10),
                                  ),
                                ),
                                Text(
                                  "Cor 1",
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: neutralFourty,
                                    letterSpacing: 0.4,
                                  ),
                                )
                              ],
                            ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Tipografia",
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: neutralTen,
                            ),
                          ),
                        ),
                        Text(
                          "A escrita precisa utilizar alguma fonte pré-definida?",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: neutralFourty,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                    Animate(
                      effects: const [FadeEffect()],
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Wrap(
                          children: [
                            for (var i = 0;
                                i < logoController.typographyList.length;
                                i++)
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    logoController.setTypographySelected(i);
                                    typography.value = TextEditingValue(
                                      text:
                                          logoController.typographyList[i].type,
                                    );
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: logoController
                                              .typographyList[i].isSelected
                                          ? mainPrimaryColor
                                          : Colors.transparent,
                                    ),
                                  ),
                                  child: Text(
                                    "Sua Marca",
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: logoController
                                          .typographyList[i].fontName,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Especificação",
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: neutralTen,
                              ),
                            ),
                          ),
                          Text(
                            "Qual a finalidade da sua logo?",
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: neutralFourty,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            for (var i = 0;
                                i < logoController.especficationSelect.length;
                                i++)
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    logoController.setEspecificationSelected(i);
                                    especification.value = TextEditingValue(
                                      text: logoController
                                          .especficationSelect[i].text,
                                    );
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: logoController
                                              .especficationSelect[i].isSelected
                                          ? mainPrimaryColor
                                          : Colors.transparent,
                                    ),
                                  ),
                                  child: Text(
                                    logoController.especficationSelect[i].text,
                                    style: GoogleFonts.roboto(
                                      color: textColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    cursorColor: mainPrimaryColor,
                    controller: description,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      fillColor: mainPrimaryColor.withOpacity(0.11),
                      filled: true,
                      suffixIcon: description.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: neutralTen,
                              ),
                              onPressed: () {
                                setState(() {
                                  description.text = "";
                                });
                              },
                            )
                          : null,
                      labelStyle: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: neutralThree,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      labelText: "Descrição",
                      helperText: "O que é isto?",
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: neutralSix,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: neutralTen,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    cursorColor: mainPrimaryColor,
                    controller: references,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      fillColor: mainPrimaryColor.withOpacity(0.11),
                      filled: true,
                      suffixIcon: references.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: neutralTen,
                              ),
                              onPressed: () {
                                setState(() {
                                  references.text = "";
                                });
                              },
                            )
                          : null,
                      labelStyle: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: neutralThree,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      labelText: "Referências",
                      helperText:
                          "Cite pelo menos 3 empresas, imagens ou sites de referência.",
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: neutralSix,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: neutralTen,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> colorPickerDialog(int index) async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChangeEnd: (value) {
        setState(() {
          logoController.addColorsText(index);
          colors.value = TextEditingValue(
            text: logoController.colorsText.join(", "),
          );
        });
      },
      onColorChanged: (Color color) {
        setState(() {
          logoController.changeColors(index, color);
        });
      },
      enableShadesSelection: false,
      width: 60,
      height: 60,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelSquarePadding: 10,
      wheelDiameter: 250,
      heading: Text(
        'Escolha uma cor',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
      colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: false,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
    ).showPickerDialog(
      context,
      actionsPadding: const EdgeInsets.all(16),
      constraints:
          const BoxConstraints(minHeight: 200, minWidth: 300, maxWidth: 320),
    );
  }
}
