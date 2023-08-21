import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/social_controller.dart';
import 'package:Mark/pages/briefing/social/social_show_page.dart';

class SocialBrienfingPage extends StatefulWidget {
  const SocialBrienfingPage({super.key});

  @override
  State<SocialBrienfingPage> createState() => _SocialBrienfingPageState();
}

class _SocialBrienfingPageState extends State<SocialBrienfingPage> {
  bool isFinished = false;

  final socialController = Get.put<SocialController>(SocialController());

  Color screenPickerColor = Colors.blue;
  Color dialogPickerColor = Colors.red;
  Color dialogSelectColor = const Color(0xFFA239CA);

  TextEditingController networkType = TextEditingController();
  TextEditingController serviceType = TextEditingController();
  TextEditingController imageBase = TextEditingController();
  TextEditingController materialQuant = TextEditingController();
  TextEditingController hoursDays = TextEditingController();
  TextEditingController midiaFormat = TextEditingController();

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
              onTap: () {
                Get.to(const SocialShowPage());
              },
              child: Container(
                width: 93,
                height: 30,
                decoration: BoxDecoration(
                  color: networkType.text.isNotEmpty &&
                          serviceType.text.isNotEmpty &&
                          imageBase.text.isNotEmpty &&
                          materialQuant.text.isNotEmpty &&
                          hoursDays.text.isNotEmpty &&
                          midiaFormat.text.isNotEmpty &&
                          midiaFormat.text.split(",").length >= 3
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
                  "SALVAR",
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: networkType.text.isNotEmpty &&
                            serviceType.text.isNotEmpty &&
                            imageBase.text.isNotEmpty &&
                            materialQuant.text.isNotEmpty &&
                            hoursDays.text.isNotEmpty &&
                            midiaFormat.text.isNotEmpty &&
                            midiaFormat.text.split(",").length >= 3
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
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    cursorColor: mainPrimaryColor,
                    controller: networkType,
                    readOnly: true,
                    onTap: () {
                      Get.defaultDialog(
                          titlePadding:
                              const EdgeInsets.only(top: 20, bottom: 20),
                          titleStyle: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              color: neutralThree,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          title: "Tipo de Rede",
                          content: StatefulBuilder(
                            builder: (context, state) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: const Text(
                                        "Quais plataformas você quer que trabalhemos?",
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        for (var item
                                            in socialController.networkTypes)
                                          InkWell(
                                            onTap: () {
                                              item.isSelected =
                                                  !item.isSelected;
                                              state(() {});
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 15),
                                              padding: const EdgeInsets.only(
                                                  bottom: 15),
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 0.5,
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(item.name),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: item.isSelected
                                                          ? mainPrimaryColor
                                                          : Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                        color: item.isSelected
                                                            ? mainPrimaryColor
                                                            : Colors.black,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: item.isSelected
                                                        ? const Icon(
                                                            Icons.check,
                                                            color: Colors.white,
                                                            size: 15,
                                                          )
                                                        : null,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 40, bottom: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 30),
                                            child: InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                "Voltar",
                                                style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                    color: neutralThree,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                "Selecionar",
                                                style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                    color: mainPrimaryColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ));
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      fillColor: mainPrimaryColor.withOpacity(0.11),
                      filled: true,
                      suffixIcon: networkType.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: neutralTen,
                              ),
                              onPressed: () {
                                setState(() {
                                  networkType.text = "";
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
                      labelText: "Tipo de Rede",
                      helperText:
                          "Quais plataformas você quer que trabalhemos?",
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
                    controller: serviceType,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      fillColor: mainPrimaryColor.withOpacity(0.11),
                      filled: true,
                      suffixIcon: serviceType.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: neutralTen,
                              ),
                              onPressed: () {
                                setState(() {
                                  serviceType.text = "";
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
                      labelText: "Tipo de Serviço",
                      helperText: "Qual o tipo de serviço a ser executado?",
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
                    controller: imageBase,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      fillColor: mainPrimaryColor.withOpacity(0.11),
                      filled: true,
                      suffixIcon: imageBase.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: neutralTen,
                              ),
                              onPressed: () {
                                setState(() {
                                  imageBase.text = "";
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
                      labelText: "Base de Imagens",
                      helperText:
                          "Você pretende fornecer as imagens, ou são contratadas?",
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
                    controller: materialQuant,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      fillColor: mainPrimaryColor.withOpacity(0.11),
                      filled: true,
                      suffixIcon: materialQuant.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: neutralTen,
                              ),
                              onPressed: () {
                                setState(() {
                                  materialQuant.text = "";
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
                      labelText: "Quantidade de Material",
                      helperText:
                          "Qual o volume de postagens em relação ao tempo?",
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
                    controller: hoursDays,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      fillColor: mainPrimaryColor.withOpacity(0.11),
                      filled: true,
                      suffixIcon: hoursDays.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: neutralTen,
                              ),
                              onPressed: () {
                                setState(() {
                                  hoursDays.text = "";
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
                      labelText: "Dias e Horários",
                      helperText:
                          "Existem dias e horários específicos a serem trabalhados?",
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
                    controller: midiaFormat,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      fillColor: mainPrimaryColor.withOpacity(0.11),
                      filled: true,
                      suffixIcon: midiaFormat.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: neutralTen,
                              ),
                              onPressed: () {
                                setState(() {
                                  midiaFormat.text = "";
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
                      labelText: "Formato da Mídia",
                      helperText:
                          "Feed, Stories, Reels ou outros. Qual tipo de Material?",
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
}
