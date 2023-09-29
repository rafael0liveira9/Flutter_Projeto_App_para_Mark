import 'dart:io';

import 'package:Mark/config/repo/archives_repo.dart';
import 'package:Mark/config/repo/site_repo.dart';
import 'package:Mark/globalController/site_controller.dart';
import 'package:Mark/globalController/user_controller.dart';
import 'package:Mark/models/logoModels/styles_model.dart';
import 'package:Mark/pages/home/view/home_page.dart';
import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/service_controller.dart';

class SiteBrienfingPage extends StatefulWidget {
  const SiteBrienfingPage({super.key});

  @override
  State<SiteBrienfingPage> createState() => _SiteBrienfingPageState();
}

class _SiteBrienfingPageState extends State<SiteBrienfingPage> {
  bool isFinished = false,
      isLoading = false,
      haveUrl = false,
      haveHost = false,
      isModelSite = false;

  final userController = Get.put<UserController>(UserController());
  final siteController = Get.put<SiteController>(SiteController());
  final serviceController = Get.put<ServiceController>(ServiceController());
  TextEditingController urlText = TextEditingController();
  TextEditingController urlNameText = TextEditingController();
  TextEditingController urlLoginText = TextEditingController();
  TextEditingController urlPasswordText = TextEditingController();

  TextEditingController hostText = TextEditingController();
  TextEditingController hostLoginText = TextEditingController();
  TextEditingController hostPasswordText = TextEditingController();

  TextEditingController siteModel = TextEditingController();
  TextEditingController references = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController socials = TextEditingController();
  TextEditingController fileController = TextEditingController();
  TextEditingController colors = TextEditingController();

  Color screenPickerColor = Colors.blue;
  Color dialogPickerColor = Colors.red;
  Color dialogSelectColor = const Color(0xFFA239CA);

  FilePickerResult? fileRealized;
  FilePickerResult? fileBriefing;
  FilePickerResult? fileLogo;

  late StylesModel siteModelVal;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(references.text.split(","));
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
            Text(
              "Website",
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
                if (description.text.isNotEmpty &&
                    references.text.isNotEmpty &&
                    references.text.split(",").length >= 3 &&
                    siteController.colorsText.isNotEmpty) {
                  if (!isLoading) {
                    setState(() {
                      isLoading = true;
                    });

                    List archives = [];
                    String urlBriefingData = '';
                    String logoUrl = '';

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

                            archives.add(archiveData.data["url"]);
                          }
                        }
                      }

                      if (fileLogo != null) {
                        final multiPartdata = await MultipartFile.fromFile(
                          fileLogo!.files.first.path!,
                        );
                        final formData = FormData.fromMap({
                          "file": multiPartdata,
                        });

                        Response archiveData =
                            await ArchivesRepo.sendArchives(data: formData);

                        logoUrl = archiveData.data["url"];
                      }

                      if (fileBriefing != null) {
                        final multiPartdata = await MultipartFile.fromFile(
                          fileBriefing!.files.first.path!,
                        );
                        final formData = FormData.fromMap({
                          "file": multiPartdata,
                        });

                        Response archiveData =
                            await ArchivesRepo.sendArchives(data: formData);

                        urlBriefingData = archiveData.data["url"];
                      }

                      Response response = await SiteRepo.sendBriefing({
                        "url": urlText.text,
                        "logo": logoUrl,
                        "contactData": contact.text,
                        "socialMidia": socials.text,
                        "references": references.text.split(", "),
                        "companieId": serviceController.companieId.value,
                        "archives": archives,
                        "colors": siteController.colorSelected
                            .map((element) => "#${element.color.hex}")
                            .toList(),
                        "urlName": urlNameText.text,
                        "urlLogin": urlLoginText.text,
                        "urlPass": urlPasswordText.text,
                        "host": hostText.text,
                        "hostPass": hostPasswordText.text,
                        "hostLogin": hostLoginText.text,
                        "urlBriefing": urlBriefingData,
                        "id": serviceController.serviceId.value
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
                } else {
                  ElegantNotification.error(
                    description: const Text("Preencha todos os campos"),
                  ).show(context);
                }
              },
              child: Container(
                width: 93,
                height: 30,
                decoration: BoxDecoration(
                  color: description.text.isNotEmpty &&
                          references.text.isNotEmpty &&
                          references.text.split(",").length >= 3 &&
                          siteController.colorsText.isNotEmpty
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
                    color: description.text.isNotEmpty &&
                            references.text.isNotEmpty &&
                            references.text.split(",").length >= 3 &&
                            siteController.colorsText.isNotEmpty
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
      body: IgnorePointer(
        ignoring: isLoading,
        child: Stack(
          children: [
            ListView(
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
                HaveUrl(),
                if (haveUrl) HaveUrlInput(),
                HaveHost(),
                if (haveHost) HaveHostInput(),
                ReferencesInput(),
                DescriptionInput(),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Column(
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
                            "Existe alguma cor que não possa ficar de fora do seu site?",
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
                                i < siteController.colorSelected.length;
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
                                          siteController.colorSelected[i].color,
                                      margin: const EdgeInsets.only(bottom: 10),
                                    ),
                                  ),
                                  Text(
                                    "Cor ${i + 1}",
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
                ),
                HaveLogoInputs(),
                ContactDataInput(),
                SocialMediaInput(),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowMultiple: true,
                        allowedExtensions: ["pdf", "png", "jpg"],
                      );

                      if (result != null) {
                        fileRealized = result;
                      } else {
                        // User canceled the picker
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
                    child: Text(
                      fileRealized != null && fileRealized!.files.isEmpty
                          ? "Enviar imagens de produtos ou serviços realizados"
                          : "Edite as imagens de produtos ou serviços realizados",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowMultiple: true,
                        allowedExtensions: ["docx", "pdf", "pptx"],
                      );

                      if (result != null) {
                        fileBriefing = result;
                      } else {
                        // User canceled the picker
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
                    child: Text(
                      fileBriefing != null && fileBriefing!.files.isEmpty
                          ? "Enviar Briefing do Site"
                          : "Editar Briefing do Site",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (isModelSite) ModalContainer(context)
          ],
        ),
      ),
    );
  }

  Container ModalContainer(BuildContext context) {
    return Container(
      color: backgroundColor.withOpacity(0.4),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        height: 332,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [defaultBoxShadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Modelo de Site",
              style: GoogleFonts.roboto(
                fontSize: 24,
                color: neutralTen,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              child: Text(
                "Qual formato de site melhor se adequa à suas necessidades?",
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: neutralTen,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            for (var i = 0; i < siteController.stylesSelect.length; i++)
              InkWell(
                onTap: () {
                  for (var a = 0; a < siteController.stylesSelect.length; a++) {
                    siteController.stylesSelect[a].isSelected = false;
                  }
                  setState(() {
                    siteController.stylesSelect[i].isSelected =
                        !siteController.stylesSelect[i].isSelected;
                    siteModelVal = siteController.stylesSelect[i];
                    siteModel.text = siteController.stylesSelect[i].text;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(siteController.stylesSelect[i].text),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width:
                              siteController.stylesSelect[i].isSelected ? 3 : 2,
                          color: siteController.stylesSelect[i].isSelected
                              ? mainPrimaryColor
                              : Colors.grey.shade600,
                        ),
                      ),
                      padding: const EdgeInsets.all(3),
                      child: siteController.stylesSelect[i].isSelected
                          ? Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: mainPrimaryColor,
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      for (var a = 0;
                          a < siteController.stylesSelect.length;
                          a++) {
                        siteController.stylesSelect[a].isSelected = false;
                      }
                      isModelSite = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      "Cancelar",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: neutralSix,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    setState(() {
                      for (var a = 0;
                          a < siteController.stylesSelect.length;
                          a++) {
                        siteController.stylesSelect[a].isSelected = false;
                      }
                      isModelSite = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: mainPrimaryColor,
                          )
                        : Text(
                            "Aprovar",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: mainPrimaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container SocialMediaInput() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextFormField(
        cursorColor: mainPrimaryColor,
        controller: socials,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          fillColor: mainPrimaryColor.withOpacity(0.11),
          filled: true,
          // suffixIcon: description.text.isNotEmpty
          //     ? IconButton(
          //         icon: const Icon(
          //           Icons.cancel_outlined,
          //           color: neutralTen,
          //         ),
          //         onPressed: () {
          //           setState(() {
          //             description.text = "";
          //           });
          //         },
          //       )
          //     : null,
          labelStyle: GoogleFonts.roboto(
            textStyle: const TextStyle(
              color: neutralThree,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          labelText: "Redes Sociais",
          helperText: "Quais são as suas redes?",
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
    );
  }

  Container ContactDataInput() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextFormField(
        cursorColor: mainPrimaryColor,
        controller: contact,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          fillColor: mainPrimaryColor.withOpacity(0.11),
          filled: true,
          // suffixIcon: description.text.isNotEmpty
          //     ? IconButton(
          //         icon: const Icon(
          //           Icons.cancel_outlined,
          //           color: neutralTen,
          //         ),
          //         onPressed: () {
          //           setState(() {
          //             description.text = "";
          //           });
          //         },
          //       )
          //     : null,
          labelStyle: GoogleFonts.roboto(
            textStyle: const TextStyle(
              color: neutralThree,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          labelText: "Dados para Contato",
          helperText: "Como seus clientes entrarão em contato com você?",
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
    );
  }

  Container HaveLogoInputs() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: TextFormField(
              readOnly: true,
              cursorColor: mainPrimaryColor,
              controller: fileController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                fillColor: mainPrimaryColor.withOpacity(0.11),
                filled: true,
                // suffixIcon: description.text.isNotEmpty
                //     ? IconButton(
                //         icon: const Icon(
                //           Icons.cancel_outlined,
                //           color: neutralTen,
                //         ),
                //         onPressed: () {
                //           setState(() {
                //             description.text = "";
                //           });
                //         },
                //       )
                //     : null,
                labelStyle: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: neutralThree,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                labelText: "Logo",
                helperText: "Você já possui uma logo?",
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
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(type: FileType.any);

                if (result != null) {
                  File file = File(result.files.single.path!);
                  fileController.text = result.files[0].name;
                  fileLogo = result;
                } else {
                  // User canceled the picker
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
              child: Text(
                "Carregar",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container DescriptionInput() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextFormField(
        cursorColor: mainPrimaryColor,
        controller: description,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          fillColor: mainPrimaryColor.withOpacity(0.11),
          filled: true,
          // suffixIcon: description.text.isNotEmpty
          //     ? IconButton(
          //         icon: const Icon(
          //           Icons.cancel_outlined,
          //           color: neutralTen,
          //         ),
          //         onPressed: () {
          //           setState(() {
          //             description.text = "";
          //           });
          //         },
          //       )
          //     : null,
          labelStyle: GoogleFonts.roboto(
            textStyle: const TextStyle(
              color: neutralThree,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          labelText: "Descrição",
          helperText: "Descreva um pouco da finalidade do seu site.",
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
    );
  }

  Container ReferencesInput() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextFormField(
        cursorColor: mainPrimaryColor,
        controller: references,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          fillColor: mainPrimaryColor.withOpacity(0.11),
          filled: true,
          // suffixIcon: description.text.isNotEmpty
          //     ? IconButton(
          //         icon: const Icon(
          //           Icons.cancel_outlined,
          //           color: neutralTen,
          //         ),
          //         onPressed: () {
          //           setState(() {
          //             description.text = "";
          //           });
          //         },
          //       )
          //     : null,
          labelStyle: GoogleFonts.roboto(
            textStyle: const TextStyle(
              color: neutralThree,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          labelText: "Referências",
          hintText: "linkdosite.com.br",
          helperText: "Quais sites você tem como inspiração para o seu?",
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
    );
  }

  Widget HaveHostInput() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            cursorColor: mainPrimaryColor,
            controller: hostText,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              fillColor: mainPrimaryColor.withOpacity(0.11),
              filled: true,
              suffixIcon: hostText.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: neutralTen,
                      ),
                      onPressed: () {
                        setState(() {
                          hostText.text = "";
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
              labelText: "Link da Hospedagem",
              helperText:
                  "Qual link da hospedagem que deseja colocar o seu site?",
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
            controller: hostLoginText,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              fillColor: mainPrimaryColor.withOpacity(0.11),
              filled: true,
              suffixIcon: hostLoginText.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: neutralTen,
                      ),
                      onPressed: () {
                        setState(() {
                          hostLoginText.text = "";
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
              labelText: "Login da Hospedagem",
              helperText:
                  "Qual o login da hospedagem que deseja colocar o seu site?",
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
            controller: hostPasswordText,
            obscureText: true,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              fillColor: mainPrimaryColor.withOpacity(0.11),
              filled: true,
              suffixIcon: hostPasswordText.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: neutralTen,
                      ),
                      onPressed: () {
                        setState(() {
                          hostPasswordText.text = "";
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
              labelText: "Senha da Hospedagem",
              helperText:
                  "Qual o senha da hospedagem que deseja colocar o seu site?",
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
    );
  }

  Container HaveHost() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: haveHost,
                onChanged: (value) {
                  setState(() {
                    haveHost = value!;
                  });
                },
              ),
              Flexible(
                child: Text(
                  "Você possui um local já contratado para hospedar o site?",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: neutralFourty,
                    letterSpacing: 0.4,
                  ),
                ),
              )
            ],
          ),
          if (!haveHost)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                "Vamos ajudá-lo no processo de hospedagem em nossos servidores, e maiores informações serão enviadas para o e-mail ${userController.userdata.value?.User?.email}.",
                style: GoogleFonts.roboto(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: neutralFourty,
                  letterSpacing: 0,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Column HaveUrlInput() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            cursorColor: mainPrimaryColor,
            controller: urlNameText,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              fillColor: mainPrimaryColor.withOpacity(0.11),
              filled: true,
              suffixIcon: urlNameText.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: neutralTen,
                      ),
                      onPressed: () {
                        setState(() {
                          urlNameText.text = "";
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
              labelText: "Site do Dominio",
              helperText: "Informe qual site comprou seu dominio",
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
            controller: urlText,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              fillColor: mainPrimaryColor.withOpacity(0.11),
              filled: true,
              suffixIcon: urlText.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: neutralTen,
                      ),
                      onPressed: () {
                        setState(() {
                          urlText.text = "";
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
              labelText: "Minha URL",
              helperText: "Informe qual o endereço do seu site.",
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
            controller: urlLoginText,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              fillColor: mainPrimaryColor.withOpacity(0.11),
              filled: true,
              suffixIcon: urlLoginText.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: neutralTen,
                      ),
                      onPressed: () {
                        setState(() {
                          urlLoginText.text = "";
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
              labelText: "Login do Dominio",
              helperText: "Informe qual o login do site do dominio.",
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
            controller: urlPasswordText,
            onChanged: (value) {
              setState(() {});
            },
            obscureText: true,
            decoration: InputDecoration(
              fillColor: mainPrimaryColor.withOpacity(0.11),
              filled: true,
              suffixIcon: urlPasswordText.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: neutralTen,
                      ),
                      onPressed: () {
                        setState(() {
                          urlPasswordText.text = "";
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
              labelText: "Senha do Dominio",
              helperText: "Informe qual a senha do site do dominio.",
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
    );
  }

  Container HaveUrl() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: haveUrl,
                onChanged: (value) {
                  setState(() {
                    haveUrl = value!;
                  });
                },
              ),
              Flexible(
                child: Text(
                  "Já possuo o registro de uma URL.",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: neutralFourty,
                    letterSpacing: 0.4,
                  ),
                ),
              )
            ],
          ),
          if (!haveUrl)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                "Vamos ajudá-lo a comprar o domínio, e maiores informações serão enviadas para o e-mail ${userController.userdata.value?.User?.email}.",
                style: GoogleFonts.roboto(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: neutralFourty,
                  letterSpacing: 0,
                ),
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
          siteController.addColorsText(index);
          colors.value = TextEditingValue(
            text: siteController.colorsText.join(", "),
          );
        });
      },
      onColorChanged: (Color color) {
        setState(() {
          siteController.changeColors(index, color);
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
