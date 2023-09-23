import 'package:Mark/models/contratedModels/social_contrated_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/service_controller.dart';

class SocialRejectPage extends StatefulWidget {
  const SocialRejectPage({super.key, required this.social});
  final SocialFeedModel social;

  @override
  State<SocialRejectPage> createState() => _SocialRejectPageState();
}

class _SocialRejectPageState extends State<SocialRejectPage> {
  bool isLoading = false;
  final serviceController = Get.put<ServiceController>(ServiceController());
  TextEditingController reason = TextEditingController();
  SocialFeedModel? social;

  @override
  void initState() {
    super.initState();
    social = widget.social;
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
                      "Recusar Publicação 1/15",
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: neutralTen,
                      ),
                    ),
                  ),
                  Text(
                    "Você não gostou da proposta? Gostaria de uma nova sugestão, ou apenas algumas poucas alterações? Por favor diga-nos abaixo como podemos prosseguir para melhor atender suas necessidades.",
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
                        social!.reasonRefuse = reason.text;
                        Get.back(result: social);
                        Get.back(result: social);
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
            ],
          ),
        ),
      ),
    );
  }
}
