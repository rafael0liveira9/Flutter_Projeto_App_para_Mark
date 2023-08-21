import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/payment/payment_controller.dart';
import 'package:Mark/pages/payment/screens/checkout_payment_page.dart';

class PackagesPaymentPage extends StatefulWidget {
  const PackagesPaymentPage({super.key});

  @override
  State<PackagesPaymentPage> createState() => _PackagesPaymentPageState();
}

class _PackagesPaymentPageState extends State<PackagesPaymentPage> {
  PaymentController paymentController = Get.put<PaymentController>(
    PaymentController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            if (paymentController.packagesSelected.isNotEmpty) {
              Get.to(const CheckoutPaymentPage());
            } else {
              ElegantNotification.error(
                description: const Text(
                  "Você precisa escolher um Produto!",
                ),
              ).show(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: paymentController.packagesSelected.isNotEmpty
                ? mainSecondayColor
                : greyColor,
          ),
          child: Text(
            "Avançar",
            style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: paymentController.packagesSelected.isNotEmpty
                    ? Colors.white
                    : Colors.grey[400]),
          ),
        ),
      ),
      body: SafeArea(
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
            for (var element in paymentController.packagesSearched)
              ServiceItemFlex(
                name: element.name,
                status: element.description,
                onTap: () {
                  Get.bottomSheet(StatefulBuilder(
                    builder: (context, setstate) {
                      return Container(
                        height: 500,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              element.name,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: mainSecondayColor,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: RichText(
                                text: TextSpan(
                                  text: "apenas ",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: neutralTen,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "R\$ ${element.price.toStringAsFixed(2).replaceAll(".", ",")}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: neutralTen,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " por mês",
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: neutralTen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  for (var item in element.PackagesServices)
                                    Container(
                                      width: double.maxFinite,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10,
                                      ),
                                      child: Card(
                                        shadowColor: Colors.transparent,
                                        color: Colors.grey[200],
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: Text(
                                            item.Service.description,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: neutralTen,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 60,
                              margin: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    for (var i = 0;
                                        i <
                                            paymentController
                                                .packagesSearched.length;
                                        i++) {
                                      paymentController.packagesSearched[i]
                                          .isSelected = false;
                                    }
                                    paymentController.packagesSelected.value =
                                        [];
                                    element.isSelected = true;
                                    paymentController.packagesSelected
                                        .add(element);
                                  });
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainPrimaryColor,
                                ),
                                child: Text(
                                  "ESCOLHER ESTE",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ));
                },
                content: Container(
                  margin: const EdgeInsets.all(10),
                  width: double.maxFinite,
                  child: Wrap(
                    children: [
                      for (var item in element.PackagesServices)
                        Card(
                          shadowColor: Colors.transparent,
                          color: mainSecondayColor,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Text(
                              item.Service.name,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                value:
                    "R\$ ${element.price.toStringAsFixed(2).replaceAll(".", ",")}",
                isSelected: element.isSelected,
              )
          ],
        ),
      ),
    );
  }

  Container headerValueSelect() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Text(
        "Aqui está alguns planos sugeridos para você:",
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: mainPrimaryColor,
        ),
      ),
    );
  }
}

class ServiceItemFlex extends StatelessWidget {
  const ServiceItemFlex(
      {super.key,
      required this.name,
      required this.status,
      required this.onTap,
      required this.value,
      this.content,
      required this.isSelected});

  final String name;
  final String value;
  final String status;
  final Widget? content;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: isSelected
                ? Border.all(
                    color: successColor,
                    strokeAlign: BorderSide.strokeAlignInside)
                : null,
            boxShadow: [
              defaultBoxShadow,
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                    ),
                    height: 56,
                    decoration: const BoxDecoration(
                      color: mainPrimaryColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            name,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            value,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (content != null) content!,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Descrição",
                            style: GoogleFonts.roboto(
                              color: neutralSix,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          status,
                          style: GoogleFonts.roboto(
                            color: yellowColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
