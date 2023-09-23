import 'package:Mark/config/repo/archives_repo.dart';
import 'package:Mark/config/repo/social_repo.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/pages/home/view/home_page.dart';
import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/social_controller.dart';

class SocialBrienfingPage extends StatefulWidget {
  const SocialBrienfingPage({super.key});

  @override
  State<SocialBrienfingPage> createState() => _SocialBrienfingPageState();
}

class _SocialBrienfingPageState extends State<SocialBrienfingPage> {
  bool isFinished = false;
  bool isLoading = false;

  final socialController = Get.put<SocialController>(SocialController());
  final serviceController = Get.put<ServiceController>(ServiceController());

  Color screenPickerColor = Colors.blue;
  Color dialogPickerColor = Colors.red;
  Color dialogSelectColor = const Color(0xFFA239CA);

  TextEditingController hoursDays = TextEditingController();
  TextEditingController socialTalk = TextEditingController();

  FilePickerResult? fileRealized;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightWhite,
        leadingWidth: 230,
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
            Flexible(
              child: Text(
                "Redes Sociais",
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  color: neutralTen,
                  fontWeight: FontWeight.w700,
                ),
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

                  List archives = [];

                  try {
                    if (fileRealized != null) {
                      if (fileRealized!.files.isNotEmpty) {
                        for (var file in fileRealized!.files) {
                          final multiPartdata = await MultipartFile.fromFile(
                            file.path!,
                          );
                          final formData = FormData.fromMap({
                            "file": multiPartdata,
                          });

                          Response archiveData =
                              await ArchivesRepo.sendArchives(data: formData);

                          archives.add({"url": archiveData.data["url"]});
                        }
                      }
                    }

                    Response response = await SocialRepo.sendBriefing({
                      "id": serviceController.serviceId.value,
                      "materiaFormat": socialController.materialFormat
                          .where((p0) => p0.isSelected)
                          .first
                          .value,
                      "productImages": archives,
                      "weekDays": socialController.weekDays
                          .where((p0) => p0.isSelected)
                          .map((e) => {"day": e.day})
                          .toList(),
                      "daysHours": hoursDays.text,
                      "mediaReference": "",
                      "socialTalk": socialTalk.text,
                      "socialProductText": "reference"
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
                    print(e.response?.data);
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
                  color: socialController.materialFormat.value
                              .any((p0) => p0.isSelected) &&
                          socialController.weekDays.value
                              .any((p0) => p0.isSelected) &&
                          hoursDays.text.isNotEmpty &&
                          socialTalk.text.isNotEmpty
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
                    color: socialController.materialFormat
                                .any((p0) => p0.isSelected) &&
                            socialController.weekDays
                                .any((p0) => p0.isSelected) &&
                            hoursDays.text.isNotEmpty &&
                            socialTalk.text.isNotEmpty
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
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Text(
                          "Selecione os dias das postagens",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: neutralTen,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.spaceAround,
                          children: [
                            for (var i = 0;
                                i < socialController.weekDays.length;
                                i++)
                              InkWell(
                                onTap: () {
                                  socialController.weekDays[i].isSelected =
                                      !socialController.weekDays[i].isSelected;
                                  setState(() {});
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      socialController.weekDays[i].day,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: mainPrimaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: socialController
                                              .weekDays[i].isSelected
                                          ? const Icon(
                                              Icons.check,
                                              size: 14,
                                            )
                                          : null,
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
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
                      labelText: "Horários",
                      hintText: "8h30, 18h30",
                      helperText:
                          "Existem horários específicos a serem trabalhados?",
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
                /* Feed, Stories e Reels
                Você receberá materiais nos formatos
                 */

                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    cursorColor: mainPrimaryColor,
                    controller: socialTalk,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      fillColor: mainPrimaryColor.withOpacity(0.11),
                      filled: true,
                      suffixIcon: socialTalk.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: neutralTen,
                              ),
                              onPressed: () {
                                setState(() {
                                  socialTalk.text = "";
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
                      labelText: "O que devemos falar em sua rede social",
                      helperText: "Como sua rede social deve conversar?",
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
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        "Como você gostaria que fosse o seu material?",
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: neutralTen,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var item in socialController.materialFormat)
                          InkWell(
                            onTap: () {
                              for (var i = 0;
                                  i < socialController.materialFormat.length;
                                  i++) {
                                socialController.materialFormat[i].isSelected =
                                    false;
                              }
                              setState(() {
                                item.isSelected = !item.isSelected;
                              });
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Text(item.materialFormat),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: item.isSelected
                                        ? const Icon(
                                            Icons.check,
                                          )
                                        : null,
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Text(
                          "Imagens do Negócio/Produto/Serviço",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: neutralTen,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowMultiple: true,
                                allowedExtensions: ["pdf", "png", "jpg"],
                              );

                              if (result != null) {
                                fileRealized = result;
                                setState(() {});
                              } else {
                                // User canceled the picker
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF362F30,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 30,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                fileRealized != null &&
                                        fileRealized!.files.isNotEmpty
                                    ? "Editar"
                                    : "Enviar",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "Envie imagens que ajudem ou mostrem mais sobre o que será falado em sua rede social. Elas servirão como base para nossa equipe criar o material",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
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
