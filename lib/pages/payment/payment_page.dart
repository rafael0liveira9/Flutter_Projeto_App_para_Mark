import 'package:Mark/config/repo/packages_repo.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/payment/payment_controller.dart';
import 'package:Mark/models/paymentModels/package_model.dart';
import 'package:Mark/pages/payment/screens/packages_payment_page.dart';
import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  double sliderVal = 199.90;
  bool isLogoSelected = true,
      isSocialSelected = true,
      isSiteSelected = true,
      isLoading = false;

  PaymentController paymentController =
      Get.put<PaymentController>(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: isLoading
          ? null
          : Container(
              height: 60,
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () async {
                  if (!isLoading) {
                    setState(() {
                      isLoading = true;
                    });
                    ElegantNotification.info(
                      description: const Text("Buscando ofertas para você!"),
                    ).show(context);
                    try {
                      Response response = await PackagesRepo.searchPackages(
                        sliderVal,
                        isLogoSelected,
                        isSiteSelected,
                        isSocialSelected,
                      );
                      setState(() {
                        isLoading = false;
                        paymentController.packagesSelected.value = [];
                        paymentController.packagesSearched.value =
                            List.from(response.data as List)
                                .map((e) => PackageModel.fromMap(e))
                                .toList();
                      });

                      return Get.to(() => const PackagesPaymentPage());
                    } catch (e) {
                      ElegantNotification.error(
                        description: const Text("Ocorreu um erro"),
                      ).show(context);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainSecondayColor,
                ),
                child: Text(
                  "Ver Planos",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              children: [
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/icons/logo_mark.png",
                      ),
                    ),
                  ),
                ),
                headerValueSelect(),
                cardContainerSelect(
                    "Deseja a criação ou melhoria de uma Logo para a sua Marca?",
                    isLogoSelected, () {
                  setState(() {
                    isLogoSelected = false;
                  });
                }, () {
                  setState(() {
                    isLogoSelected = true;
                  });
                }),
                cardContainerSelect(
                    "Deseja a criação ou otimização de Redes Sociais para sua Empresa?",
                    isSocialSelected, () {
                  setState(() {
                    isSocialSelected = false;
                  });
                }, () {
                  setState(() {
                    isSocialSelected = true;
                  });
                }),
                cardContainerSelect(
                    "Deseja a criação ou melhoria de um Site para a sua Empresa?",
                    isSiteSelected, () {
                  setState(() {
                    isSiteSelected = false;
                  });
                }, () {
                  setState(() {
                    isSiteSelected = true;
                  });
                }),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.grey[800]!.withOpacity(0.6),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: mainPrimaryColor,
              ),
            ),
        ],
      ),
    );
  }

  Card cardContainerSelect(String topText, bool value, VoidCallback onTapFalse,
      VoidCallback onTapTrue) {
    return Card(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Text(
              topText,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: onTapTrue,
                child: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      Radio(
                        value: value,
                        groupValue: true,
                        onChanged: (value) {
                          onTapTrue();
                        },
                        activeColor: mainPrimaryColor,
                      ),
                      Text(
                        "Sim",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: onTapFalse,
                child: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      Radio(
                        value: value,
                        groupValue: false,
                        onChanged: (value) {
                          onTapFalse();
                        },
                        activeColor: mainPrimaryColor,
                      ),
                      Text(
                        "Não",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column headerValueSelect() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Text(
            "Qual valor mensal deseja investir em Marketing Digital?",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: mainPrimaryColor,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                "Valor Selecionado",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "R\$ ${sliderVal.toStringAsFixed(2).replaceAll(".", ",")}",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Slider(
            activeColor: mainPrimaryColor,
            secondaryActiveColor: mainPrimaryColor.withOpacity(0.5),
            inactiveColor: mainPrimaryColor.withOpacity(0.5),
            divisions: 3,
            min: 199.90,
            max: 799.90,
            value: sliderVal,
            onChanged: (value) {
              setState(() {
                sliderVal = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
