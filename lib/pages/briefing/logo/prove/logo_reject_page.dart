import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/config/repo/logo_repo.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/models/contratedModels/logo_contrated_item_model.dart';
import 'package:Mark/pages/home/view/home_page.dart';

class LogoRejectPage extends StatefulWidget {
  const LogoRejectPage({super.key, required this.logoProof});
  final LogoProofModel logoProof;

  @override
  State<LogoRejectPage> createState() => _LogoRejectPageState();
}

class _LogoRejectPageState extends State<LogoRejectPage> {
  bool isLoading = false;
  final serviceController = Get.put<ServiceController>(ServiceController());
  TextEditingController reason = TextEditingController();

  Future reprooveLogo() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        Response response = await LogoRepo.updateProof(
          serviceController.serviceId.value,
          serviceController.proofId.value,
          false,
          reason.text,
        );

        ElegantNotification.success(
          description: const Text("Logo rejeitada com sucesso!"),
          onProgressFinished: () {
            Get.off(const HomePage());
          },
        ).show(context);
      } on DioException catch (e) {
        ElegantNotification.error(
                description: Text(
                    "Ocorreu um erro ao atualizar a logo: ${e.response?.data}"))
            .show(context);
        print(e.response?.data);
      }
    }
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
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: IgnorePointer(
          ignoring: isLoading,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Recusar Logo",
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: neutralTen,
                      ),
                    ),
                  ),
                  Text(
                    "Você não gostou da logo proposta? Gostaria de uma nova sugestão, ou apenas algumas poucas alterações? Por favor diga-nos abaixo como podemos prosseguir para melhor atender suas necessidades.",
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
                child: TextFormField(
                  cursorColor: mainPrimaryColor,
                  controller: reason,
                  decoration: InputDecoration(
                    fillColor: mainPrimaryColor.withOpacity(0.11),
                    filled: true,
                    labelStyle: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: neutralThree,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    labelText: "Observações",
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
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: neutralSix,
                          boxShadow: [
                            defaultBoxShadow,
                          ],
                        ),
                        child: Text(
                          "Cancelar",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await reprooveLogo();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: mainPrimaryColor,
                          boxShadow: [
                            defaultBoxShadow,
                          ],
                        ),
                        child: Text(
                          isLoading ? "Enviando..." : "Confirmar",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 396,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    defaultBoxShadow,
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: FadeInImage(
                  placeholder: const AssetImage(
                    "assets/images/rectangleOrange.png",
                  ),
                  image: NetworkImage(
                    widget.logoProof.proofImage.url,
                  ),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/rectangleOrange.png',
                      fit: BoxFit.cover,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
