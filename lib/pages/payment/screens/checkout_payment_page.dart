import 'package:Mark/config/repo/payment_repo.dart';
import 'package:Mark/pages/home/view/home_page.dart';
import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask/mask.dart';

import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/payment/payment_controller.dart';
import 'package:Mark/utils/utils.dart';

class CheckoutPaymentPage extends StatefulWidget {
  const CheckoutPaymentPage({super.key});

  @override
  State<CheckoutPaymentPage> createState() => _CheckoutPaymentPageState();
}

class _CheckoutPaymentPageState extends State<CheckoutPaymentPage> {
  double sliderVal = 199.90;
  bool isLoading = false, isCredit = true;
  TextEditingController creditNumber =
      TextEditingController(text: "5162 3062 1937 8829");
  TextEditingController cvcNumber = TextEditingController(text: "318");
  TextEditingController userName = TextEditingController(text: "Rafael Teste");
  TextEditingController valid = TextEditingController(text: "02/2024");
  String creditLogo = "";
  int installments = 1;
  int? installmentsSelected;

  PaymentController paymentController = Get.put<PaymentController>(
    PaymentController(),
  );

  void getInstallmentsLimit() {
    while (installments < 12) {
      if (paymentController.packagesSelected[0].price / installments > 100) {
        installments++;
      } else {
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        getInstallmentsLimit();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: isLoading
          ? null
          : Container(
              height: 100,
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total: ",
                          style: GoogleFonts.roboto(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: mainPrimaryColor,
                          ),
                        ),
                        if (installmentsSelected != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "R\$ ${paymentController.packagesSelected[0].price.toStringAsFixed(2).replaceAll(".", ",")} ${isCredit && installmentsSelected! > 1 ? "em ${installmentsSelected}x" : ""}",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: mainSecondayColor,
                                ),
                              ),
                              if (isCredit && installmentsSelected! > 1)
                                Text(
                                  "R\$ ${(paymentController.packagesSelected[0].price / installmentsSelected!).floor().toStringAsFixed(2).replaceAll(".", ",")}/mês",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: neutralTen,
                                  ),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        if ((creditNumber.text.isNotEmpty &&
                                valid.text.isNotEmpty &&
                                cvcNumber.text.isNotEmpty &&
                                userName.text.isNotEmpty &&
                                installmentsSelected != null) ||
                            !isCredit) {
                          setState(() {
                            paymentController.creditNumber.value =
                                creditNumber.text;
                            paymentController.cvcNumber.value = cvcNumber.text;
                            paymentController.userName.value = userName.text;
                            paymentController.valid.value = valid.text;
                          });
                          if (!isLoading) {
                            setState(() {
                              isLoading = true;
                            });
                            if (installmentsSelected == null) {
                              return ElegantNotification.error(
                                description: const Text(
                                    "Selecione um número possível de parcelas."),
                                onProgressFinished: () {
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                              ).show(context);
                            }
                            ElegantNotification.info(
                              description:
                                  const Text("Finalizando seu pagamento!"),
                            ).show(context);
                            try {
                              Response response =
                                  await PaymentRepo.checkoutPayment(
                                      installmentsSelected!);

                              ElegantNotification.success(
                                description:
                                    const Text("Processando seu pagamento..."),
                                onProgressFinished: () {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Get.to(const HomePage());
                                },
                              ).show(context);
                            } catch (e) {
                              ElegantNotification.error(
                                description: const Text("Ocorreu um erro"),
                              ).show(context);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        } else {
                          ElegantNotification.error(
                            description:
                                const Text("Preencha todos os campos!"),
                          ).show(context);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (creditNumber.text.isNotEmpty &&
                                    valid.text.isNotEmpty &&
                                    cvcNumber.text.isNotEmpty &&
                                    userName.text.isNotEmpty &&
                                    installmentsSelected != null) ||
                                !isCredit
                            ? mainSecondayColor
                            : Colors.grey,
                      ),
                      child: Text(
                        "Finalizar Pagamento",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: (creditNumber.text.isNotEmpty &&
                                      valid.text.isNotEmpty &&
                                      cvcNumber.text.isNotEmpty &&
                                      userName.text.isNotEmpty &&
                                      installmentsSelected != null) ||
                                  !isCredit
                              ? Colors.white
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                ],
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
                SelectMethodType(),
                if (isCredit) InputsCreditCard(),
                if (isCredit)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(
                          "Número de Parcelas:",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: mainPrimaryColor,
                          ),
                        ),
                      ),
                      DropdownButton(
                        value: installmentsSelected,
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            enabled: false,
                            child: Text(
                              "Selecione uma opção",
                            ),
                          ),
                          for (var i = 1; i <= installments; i++)
                            DropdownMenuItem(
                              value: i,
                              child: Text(
                                i.toString(),
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            installmentsSelected = value;
                          });
                        },
                      )
                    ],
                  ),
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

  Column InputsCreditCard() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: TextFormField(
            cursorColor: mainPrimaryColor,
            controller: creditNumber,
            onChanged: (value) {
              setState(() {
                creditLogo = getCardNumber(value.replaceAll(" ", ""));
              });
            },
            decoration: InputDecoration(
              fillColor: mainPrimaryColor.withOpacity(0.11),
              filled: true,
              suffixIcon: creditLogo.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.only(
                        right: 10,
                        bottom: 10,
                        top: 10,
                      ),
                      constraints: const BoxConstraints(
                        maxWidth: 60,
                      ),
                      height: 50,
                      child: Image.network(
                        creditLogo,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    )
                  : null,
              labelStyle: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  color: neutralThree,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              labelText: "Número do Cartão",
              hintText: "0000 0000 0000 0000",
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
              errorText:
                  creditNumber.text.isEmpty ? "Coloque aqui seu cartão" : null,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              Mask.generic(
                masks: ["#### #### #### ####"],
                hashtag: Hashtag.numbers,
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: TextFormField(
            cursorColor: mainPrimaryColor,
            controller: userName,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              fillColor: mainPrimaryColor.withOpacity(0.11),
              filled: true,
              suffixIcon: userName.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: neutralTen,
                      ),
                      onPressed: () {
                        setState(() {
                          userName.text = "";
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
              labelText: "Nome do Cartão",
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
              errorText: userName.text.isEmpty
                  ? "Coloque aqui o nome do cartão"
                  : null,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 5),
                  child: TextFormField(
                    cursorColor: mainPrimaryColor,
                    controller: valid,
                    onChanged: (value) {
                      setState(() {});
                    },
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
                      labelText: "Validade",
                      hintText: "00/0000",
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
                      errorText: valid.text.isEmpty
                          ? "Coloque aqui a validade do seu cartão"
                          : null,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      Mask.generic(
                        masks: ["##/####"],
                        hashtag: Hashtag.numbers,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    cursorColor: mainPrimaryColor,
                    controller: cvcNumber,
                    onChanged: (value) {
                      setState(() {});
                    },
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
                      labelText: "CVC",
                      hintText: "000",
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
                      errorText: cvcNumber.text.isEmpty
                          ? "Coloque aqui o código"
                          : null,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      Mask.generic(
                        masks: ["###"],
                        hashtag: Hashtag.numbers,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  SizedBox SelectMethodType() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isCredit = true;
              });
            },
            child: SizedBox(
              child: Row(
                children: [
                  Radio(
                    value: isCredit,
                    groupValue: true,
                    onChanged: (value) {
                      setState(() {
                        isCredit = true;
                      });
                    },
                    activeColor: mainPrimaryColor,
                  ),
                  Text(
                    "Cartão de Crédito",
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
            onTap: () {
              setState(() {
                isCredit = false;
              });
            },
            child: SizedBox(
              width: 100,
              child: Row(
                children: [
                  Radio(
                    value: isCredit,
                    groupValue: false,
                    onChanged: (value) {
                      setState(() {
                        isCredit = false;
                      });
                    },
                    activeColor: mainPrimaryColor,
                  ),
                  Text(
                    "Pix",
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
    );
  }

  Container headerValueSelect() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Text(
        "Selecione o seu método de pagamento:",
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
