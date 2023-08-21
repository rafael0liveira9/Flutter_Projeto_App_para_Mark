import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/config/repo/logo_repo.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/pages/home/view/home_page.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double stars = 0;
  TextEditingController comments = TextEditingController();
  bool isLoading = false;
  final serviceController = Get.put<ServiceController>(ServiceController());

  Future sendFeedback() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        Response response = await LogoRepo.sendFeedback(
            serviceController.serviceId.value, stars, comments.text);

        ElegantNotification.success(
          description: const Text("Feedback enviado com sucesso!"),
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
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Avaliação",
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: neutralTen,
                    ),
                  ),
                ),
                Text(
                  "Sua experiência foi boa? que nota você daria para sua logo e o processo para desenvolve-la?",
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
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: RatingBar(
                itemSize: 30,
                itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: mainSecondayColor,
                  ),
                  half: const Icon(
                    Icons.star_half,
                  ),
                  empty: const Icon(
                    Icons.star_border,
                    color: neutralThree,
                  ),
                ),
                onRatingUpdate: (a) {
                  setState(() {
                    stars = a;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextFormField(
                cursorColor: mainPrimaryColor,
                controller: comments,
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
                  labelText: "Comentários",
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
                      await sendFeedback();
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
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              "Enviar",
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
    );
  }
}
