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
import 'package:Mark/pages/briefing/logo/prove/logo_reject_page.dart';
import 'package:Mark/pages/home/view/home_page.dart';
import 'package:Mark/widgets/widgets.dart';

class LogoProvePage extends StatefulWidget {
  const LogoProvePage({super.key, required this.logoProof});
  final LogoProofModel logoProof;

  @override
  State<LogoProvePage> createState() => _LogoProvePageState();
}

class _LogoProvePageState extends State<LogoProvePage> {
  bool isLoading = false, isVisible = false;
  final serviceController = Get.put<ServiceController>(ServiceController());

  Future approveLogo() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        Response response = await LogoRepo.updateProof(
          serviceController.serviceId.value,
          widget.logoProof.id,
          true,
          "",
        );

        setState(() {
          isVisible = false;
        });

        ElegantNotification.success(
          description: const Text("Logo aprovada com sucesso!"),
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
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isVisible
          ? null
          : AppBar(
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
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Provas",
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      color: neutralTen,
                      fontWeight: FontWeight.w700,
                    ),
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          serviceController.proofId.value = widget.logoProof.id;
                          Get.to(() => LogoRejectPage(
                                logoProof: widget.logoProof,
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: errorColor,
                            boxShadow: [
                              defaultBoxShadow,
                            ],
                          ),
                          child: Text(
                            "Rejeitar",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isVisible = true;
                          });
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
                            "Aprovar",
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
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Text(
                          "Aplicações",
                          style: GoogleFonts.roboto(
                            fontSize: 22,
                            color: neutralTen,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 127,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (var i = 0;
                                i < widget.logoProof.Mockups.length;
                                i++)
                              AplicationImages(
                                url: widget.logoProof.Mockups[i].image.url,
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            if (isVisible)
              Container(
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
                        "Você gostaria de\naprovar sua logo?",
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: neutralTen,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Essa ação é irreversível e uma vez que for realizada não poderá ser desfeita. \n\nIsso significa que sua logo estará pronta e não poderá mais sofrer alterações, dando assim sequência nas estapas seguintes.",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: neutralTen,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isVisible = false;
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
                              await approveLogo();
                              return;
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
              )
          ],
        ),
      ),
    );
  }
}
