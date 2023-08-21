// ignore_for_file: unnecessary_lambdas, inference_failure_on_function_return_type, prefer_final_locals, omit_local_variable_types, avoid_dynamic_calls, strict_raw_type, inference_failure_on_function_invocation, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/config/repo/auth_repo.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/db/user_db.dart';
import 'package:Mark/globalController/user_controller.dart';
import 'package:Mark/pages/account/register/view/register_page.dart';
import 'package:Mark/pages/home/view/home_page.dart';
import 'package:Mark/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool isVisible = false, isLoading = false, isViewd = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String errorPassword = '';
  String errorEmail = '';

  final userData = Get.put<UserController>(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xFF11023b),
              Color(0xFF39009d),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 20,
              ),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.network(
                "https://www.kadencewp.com/wp-content/uploads/2020/10/alogo-2.png",
              ),
            ),
            FadeInUpWidget(
              duration: const Duration(seconds: 1),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 40),
                      child: Text(
                        'Bem-vindo',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Email',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 56,
                          child: TextFormField(
                            controller: email,
                            cursorColor: neutralThree,
                            autofillHints: const [AutofillHints.email],
                            decoration: InputDecoration(
                              fillColor: Colors.white.withOpacity(0.75),
                              filled: true,
                              hintText: 'seuemail@email.com.br',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Senha',
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 56,
                            child: TextFormField(
                              controller: password,
                              cursorColor: neutralThree,
                              obscureText: !isVisible,
                              obscuringCharacter: '*',
                              autofillHints: const [AutofillHints.password],
                              decoration: InputDecoration(
                                fillColor: Colors.white.withOpacity(0.75),
                                filled: true,
                                hintText: '**********************',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  icon: Icon(
                                    isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: neutralThree,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    width: 2,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // Get.to(const HomePage());
                        if (email.text.isNotEmpty && password.text.isNotEmpty) {
                          if (!isLoading) {
                            setState(() {
                              isLoading = true;
                            });
                            Response returnLogin = await AuthRepo.loginUser(
                              email.text,
                              password.text,
                            );

                            if (returnLogin.data.containsKey('jwt') == true) {
                              try {
                                await DB().setUserdata(
                                  email.text,
                                  password.text,
                                  false,
                                );
                              } catch (e) {
                                await DB().deleteUser();
                                await DB().setUserdata(
                                  email.text,
                                  password.text,
                                  false,
                                );
                              }
                              setState(() {
                                isLoading = false;
                                userData.setUserData(
                                  returnLogin.data as Map<String, dynamic>,
                                );
                              });
                              await Get.to(const HomePage());
                            } else {
                              ElegantNotification.error(
                                description: Text(
                                  returnLogin.data['Message'].toString(),
                                ),
                              ).show(context);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        } else {
                          ElegantNotification.error(
                            description: const Text(
                              'Preencha todos os campos, por favor',
                            ),
                          ).show(context);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        width: double.maxFinite,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: mainPrimaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Entrar',
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const RegisterPage());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Ainda não tem conta? Cadastre-se',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
