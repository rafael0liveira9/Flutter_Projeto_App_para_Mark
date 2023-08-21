import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Mark/config/repo/site_repo.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/globalController/site_controller.dart';
import 'package:Mark/models/contratedModels/site_contrated_item_model.dart';
import 'package:Mark/pages/briefing/site/definition/site_view_definition_page.dart';
import 'package:Mark/pages/home/view/home_page.dart';

class SiteDefinitionPage extends StatefulWidget {
  const SiteDefinitionPage({
    super.key,
    required this.service,
  });

  final SiteContratedItem service;

  @override
  State<SiteDefinitionPage> createState() => _SiteDefinitionPageState();
}

class _SiteDefinitionPageState extends State<SiteDefinitionPage> {
  bool isLoading = false, isVisible = false;
  final serviceController = Get.put<ServiceController>(ServiceController());
  final siteController = Get.put<SiteController>(SiteController());

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getDataToController();
      return;
    });
  }

  Future sendToShow() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        Response response = await SiteRepo.updateToShow(
          serviceController.serviceId.value,
          siteController.SiteLayoutBase.firstWhere(
              (element) => element.isSelected).layout.Layout.id,
        );

        ElegantNotification.success(
          description: const Text("Website definido com sucesso!"),
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

  void getDataToController() {
    if (widget.service.SiteService.SiteLayoutBase != null &&
        widget.service.SiteService.SiteLayoutBase!.isNotEmpty) {
      setState(() {
        siteController.AddSiteLayoutBase(
            widget.service.SiteService.SiteLayoutBase!);
      });
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
                      if (siteController.SiteLayoutBase.any(
                          (element) => element.isSelected)) {
                        await sendToShow();
                      }
                    },
                    child: Container(
                      width: 93,
                      height: 30,
                      decoration: BoxDecoration(
                        color: siteController.SiteLayoutBase.any(
                                (element) => element.isSelected)
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
                          color: siteController.SiteLayoutBase.any(
                                  (element) => element.isSelected)
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
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Definição de Layout",
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      color: neutralTen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (widget.service.SiteService.SiteLayoutBase != null &&
                    widget.service.SiteService.SiteLayoutBase!.isNotEmpty)
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (var element in siteController.SiteLayoutBase)
                        Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.44,
                                  height:
                                      MediaQuery.of(context).size.width * 0.44,
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
                                      element.layout.Layout.url,
                                    ),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/rectangleOrange.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(() => SiteViewDefinitionPage(
                                            url: element.layout.Layout.url,
                                          ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: mainPrimaryColor,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      "Visualizar",
                                      style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: mainPrimaryColor,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.44,
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: element.isSelected,
                                    onChanged: (value) {
                                      for (var i = 0;
                                          i <
                                              siteController
                                                  .SiteLayoutBase.length;
                                          i++) {
                                        setState(() {
                                          siteController.SiteLayoutBase[i]
                                              .isSelected = false;
                                        });
                                      }
                                      setState(() {
                                        element.isSelected =
                                            !element.isSelected;
                                      });
                                    },
                                  ),
                                  Text(
                                    element.layout.name,
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: neutralFourty,
                                      letterSpacing: 0.4,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
