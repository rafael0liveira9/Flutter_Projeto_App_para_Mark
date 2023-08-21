import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

class SiteViewDefinitionPage extends StatefulWidget {
  const SiteViewDefinitionPage({
    super.key,
    required this.url,
  });
  final String url;

  @override
  State<SiteViewDefinitionPage> createState() => _SiteViewDefinitionPageState();
}

class _SiteViewDefinitionPageState extends State<SiteViewDefinitionPage> {
  bool isLoading = false, isVisible = false;
  final serviceController = Get.put<ServiceController>(ServiceController());

  // Future approveLogo() async {
  //   if (!isLoading) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     try {
  //       Response response = await LogoRepo.updateProof(
  //         serviceController.serviceId.value,
  //         widget.logoProof.id,
  //         true,
  //         "",
  //       );

  //       setState(() {
  //         isVisible = false;
  //       });

  //       ElegantNotification.success(
  //         description: const Text("Logo aprovada com sucesso!"),
  //         onProgressFinished: () {
  //           Get.off(const HomePage());
  //         },
  //       ).show(context);
  //     } on DioException catch (e) {
  //       ElegantNotification.error(
  //               description: Text(
  //                   "Ocorreu um erro ao atualizar a logo: ${e.response?.data}"))
  //           .show(context);
  //       print(e.response?.data);
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   }
  // }

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
