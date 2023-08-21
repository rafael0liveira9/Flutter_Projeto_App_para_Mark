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

class SiteSaveDefinitionPage extends StatefulWidget {
  const SiteSaveDefinitionPage({
    super.key,
    required this.url,
  });
  final String url;

  @override
  State<SiteSaveDefinitionPage> createState() => _SiteSaveDefinitionPageState();
}

class _SiteSaveDefinitionPageState extends State<SiteSaveDefinitionPage> {
  bool isLoading = false, isVisible = false;
  final serviceController = Get.put<ServiceController>(ServiceController());

  Future sendToShow() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        Response response =
            await SiteRepo.updateSaveShow(serviceController.serviceId.value);

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
              actions: [
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: InkWell(
                    onTap: () async {
                      await sendToShow();
                    },
                    child: Container(
                      width: 93,
                      height: 30,
                      decoration: BoxDecoration(
                        color: mainSecondayColor,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
                    "Amostra",
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
                        widget.url,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
