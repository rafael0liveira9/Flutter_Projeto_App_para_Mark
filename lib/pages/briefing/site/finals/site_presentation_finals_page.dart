import 'package:Mark/models/contratedModels/site_contrated_item_model.dart';
import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

import 'package:Mark/config/repo/site_repo.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/pages/home/view/home_page.dart';

class SitePresentitionFinalsPage extends StatefulWidget {
  const SitePresentitionFinalsPage({
    super.key,
    required this.siteLayoutFinished,
  });
  final SiteLayoutFinishedModel siteLayoutFinished;

  @override
  State<SitePresentitionFinalsPage> createState() =>
      _SitePresentitionFinalsPageState();
}

class _SitePresentitionFinalsPageState
    extends State<SitePresentitionFinalsPage> {
  bool isLoading = false, isVisible = false, isVisibleApprove = false;
  final serviceController = Get.put<ServiceController>(ServiceController());

  TextEditingController reason = TextEditingController();

  Future sendApproveData(bool isApproved) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        Response response = await SiteRepo.updateApprove(
          serviceController.serviceId.value,
          isApproved,
          reason.text,
        );

        ElegantNotification.success(
          description: const Text("Website atualizado com sucesso!"),
          onProgressFinished: () {
            Get.off(const HomePage());
          },
        ).show(context);
      } on DioException catch (e) {
        ElegantNotification.error(
                description: Text(
                    "Ocorreu um erro ao atualizar o website: ${e.response?.data}"))
            .show(context);
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
                    "Apresentação Final",
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      color: neutralTen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxHeight: 500),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      defaultBoxShadow,
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: PinchZoomReleaseUnzoomWidget(
                    child: FadeInImage(
                      placeholder: const AssetImage(
                        "assets/images/rectangleOrange.png",
                      ),
                      image: NetworkImage(
                        widget.siteLayoutFinished.LayoutFinished.url,
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
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isVisible = true;
                          });
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
                            isVisibleApprove = true;
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
              ],
            ),
            if (isVisible)
              RejectModal(
                  onTapApprove: () async {
                    await sendApproveData(false);
                  },
                  onTapCancel: () {
                    setState(() {
                      isVisible = false;
                      reason.text = "";
                    });
                  },
                  title: "Deseja rejeitar?",
                  approveName: "Rejeitar",
                  content: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          controller: reason,
                          cursorColor: mainPrimaryColor,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            fillColor: mainPrimaryColor.withOpacity(0.11),
                            filled: true,
                            suffixIcon: reason.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.cancel_outlined,
                                      color: neutralTen,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        reason.text = "";
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
                            labelText: "Razão da Recusa",
                            helperText: "Qual foi o erro encontrado?",
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
                  )),
            if (isVisibleApprove)
              RejectModal(
                onTapApprove: () async {
                  await sendApproveData(true);
                },
                onTapCancel: () {
                  setState(() {
                    isVisibleApprove = false;
                  });
                },
                title: "Deseja aprovar?",
              )
          ],
        ),
      ),
    );
  }

  Container RejectModal({
    required VoidCallback onTapCancel,
    required VoidCallback onTapApprove,
    String cancelName = "Cancelar",
    String approveName = "Aprovar",
    String title = "Placeholder",
    Widget? content,
  }) {
    return Container(
      color: backgroundColor.withOpacity(0.4),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        height: content != null ? 400 : 332,
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
              title ?? "",
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
            if (content != null) content,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onTapCancel,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      cancelName ?? "",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: neutralSix,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onTapApprove,
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
                            approveName ?? "",
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
}
