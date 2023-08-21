// ignore_for_file: unnecessary_lambdas

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/user_controller.dart';
import 'package:Mark/pages/account/login/view/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // TextEditingController cpfControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController passwordConfirmControler = TextEditingController();
  TextEditingController nameController = TextEditingController();
  // TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // TextEditingController cityUserController = TextEditingController();
  // TextEditingController zipcodeUserController = TextEditingController();
  // TextEditingController ufUserController = TextEditingController();
  // TextEditingController districtUserController = TextEditingController();
  // TextEditingController addressUserController = TextEditingController();
  // TextEditingController numberUser = TextEditingController();

  final userData = Get.put<UserController>(UserController());

  late FocusNode focusNode;
  String errorPasswordConfirm = '';

  bool isLoading = false;
  String errorPassword = '';
  String errorEmail = '';

  double progress = 0;
  bool hasSpecialMatch = false,
      hasNumberMatch = false,
      isVisible = true,
      isVisibleConfirm = true,
      termsData = false,
      receiveEmail = false,
      hasUpperMatch = false,
      focus = false,
      isEmailValid = false,
      hasMoreThen8Match = false;

  void verifyPassword(String value) {
    final password = value.trim();
    final specialCharacter = RegExp(r'\W');
    final uppercaseCharacter = RegExp('[A-Z]');
    final number = RegExp(r'\d');

    if (value.isEmpty) {
      setState(() {
        errorPassword = 'Não Pode ser vazio';
      });
    } else {
      setState(() {
        errorPassword = '';
      });
    }

    if (password.length > 8) {
      setState(() {
        hasMoreThen8Match = true;
      });
    } else {
      setState(() {
        hasMoreThen8Match = false;
      });
    }

    if (number.hasMatch(password)) {
      setState(() {
        hasNumberMatch = true;
      });
    } else {
      setState(() {
        hasNumberMatch = false;
      });
    }
    if (specialCharacter.hasMatch(password)) {
      setState(() {
        hasSpecialMatch = true;
      });
    } else {
      setState(() {
        hasSpecialMatch = false;
      });
    }
    if (uppercaseCharacter.hasMatch(password)) {
      setState(() {
        hasUpperMatch = true;
      });
    } else {
      setState(() {
        hasUpperMatch = false;
      });
    }

    if (password.isEmpty) {
      setState(() {
        progress = 0;
      });
    } else if (password.length < 6 &&
        (uppercaseCharacter.hasMatch(password) ||
            number.hasMatch(password) ||
            specialCharacter.hasMatch(password))) {
      setState(() {
        progress = 1 / 4;
      });
    } else if (password.length < 8) {
      setState(() {
        progress = 2 / 4;
      });
    } else {
      if (password.length < 8 ||
          password.length > 8 &&
              uppercaseCharacter.hasMatch(password) &&
              number.hasMatch(password) &&
              !specialCharacter.hasMatch(password)) {
        setState(() {
          progress = 3 / 4;
        });
      } else if (password.length > 8 &&
          uppercaseCharacter.hasMatch(password) &&
          number.hasMatch(password) &&
          specialCharacter.hasMatch(password)) {
        setState(() {
          progress = 1;
        });
      }
    }
  }

  void verifyConfirmPassword(String password) {
    if (password != passwordControler.text) {
      setState(() {
        errorPasswordConfirm = "Senhas não conhecidem";
      });
    } else {
      setState(() {
        errorPasswordConfirm = "";
      });
    }
  }

  void _handleFocusChange() {
    if (focusNode.hasFocus != focus) {
      setState(() {
        focus = focusNode.hasFocus;
      });
    }
  }

  void validateEmail(String value) {
    final emailRegexVal = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );

    if (emailRegexVal.hasMatch(value)) {
      setState(() {
        isEmailValid = true;
        errorEmail = '';
      });
    } else {
      setState(() {
        isEmailValid = false;
        errorEmail = 'Digite um email válido';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.removeListener(_handleFocusChange);
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: Image.network(
                "https://www.kadencewp.com/wp-content/uploads/2020/10/alogo-2.png",
              ),
            ),
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
                    'Nome',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 56,
                  child: TextFormField(
                    controller: nameController,
                    autofillHints: const [AutofillHints.email],
                    decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.75),
                      filled: true,
                      hintText: 'Digite seu nome',
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
                    controller: emailControler,
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
                      'Telefone',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 56,
                    child: TextFormField(
                      controller: phoneController,
                      autofillHints: const [AutofillHints.email],
                      onChanged: (value) {
                        String newValue;

                        if (value.isNotEmpty && value.length < 2) {
                          newValue = value.replaceAllMapped(RegExp(r'^(\d{2})'),
                              (match) {
                            return '(${match[1]})';
                          });

                          phoneController.value = TextEditingValue(
                            text: newValue,
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: newValue.length),
                            ),
                          );
                        } else if (value.length >= 6 && value.length == 8) {
                          newValue = value.replaceAllMapped(
                              RegExp(r'^(\d{2})(\d{5})'), (match) {
                            return '(${match[1]}) ${match[2]}-';
                          });

                          phoneController.value = TextEditingValue(
                            text: newValue,
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: newValue.length),
                            ),
                          );
                        } else if (value.length >= 10 && value.length < 12) {
                          newValue = value.replaceAllMapped(
                              RegExp(r'^(\d{2})(\d{5})(\d{1,})?'), (match) {
                            return '(${match[1]}) ${match[2]}-${match[3]}';
                          });

                          phoneController.value = TextEditingValue(
                            text: newValue,
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: newValue.length),
                            ),
                          );
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.75),
                        filled: true,
                        hintText: '(00) 00000-0000',
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
                      inputFormatters: [
                        FilteringTextInputFormatter(
                          RegExp('[0-9]'),
                          allow: true,
                        ),
                        LengthLimitingTextInputFormatter(11),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        height: errorPassword.isEmpty ? 56 : 86,
                        child: TextFormField(
                          controller: passwordControler,
                          obscureText: !isVisible,
                          focusNode: focusNode,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscuringCharacter: '*',
                          autofillHints: const [AutofillHints.password],
                          onChanged: verifyPassword,
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
                            errorText:
                                errorPassword.isEmpty ? null : errorPassword,
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
                if (focus)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            '- Mais de 8 caracteres *',
                            style: GoogleFonts.outfit(
                              color:
                                  hasMoreThen8Match ? neutralSix : errorColor,
                              fontSize: 16,
                              fontStyle:
                                  hasMoreThen8Match ? FontStyle.italic : null,
                              decoration: hasMoreThen8Match
                                  ? TextDecoration.lineThrough
                                  : null,
                              decorationColor: hasMoreThen8Match
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            '- Pelo menos um número *',
                            style: GoogleFonts.outfit(
                              color: hasNumberMatch ? neutralSix : errorColor,
                              fontSize: 16,
                              fontStyle:
                                  hasNumberMatch ? FontStyle.italic : null,
                              decoration: hasNumberMatch
                                  ? TextDecoration.lineThrough
                                  : null,
                              decorationColor:
                                  hasNumberMatch ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            '- Caracter Especial *',
                            style: GoogleFonts.outfit(
                              color: hasSpecialMatch ? neutralSix : errorColor,
                              fontSize: 16,
                              fontStyle:
                                  hasSpecialMatch ? FontStyle.italic : null,
                              decoration: hasSpecialMatch
                                  ? TextDecoration.lineThrough
                                  : null,
                              decorationColor:
                                  hasSpecialMatch ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          '- Pelo menos uma letra maiuscula *',
                          style: GoogleFonts.outfit(
                            color: hasUpperMatch ? neutralSix : errorColor,
                            fontSize: 16,
                            fontStyle: hasUpperMatch ? FontStyle.italic : null,
                            decoration: hasUpperMatch
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor:
                                hasUpperMatch ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                      'Confirme sua Senha',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: errorPasswordConfirm.isEmpty ? 56 : 86,
                    child: TextFormField(
                      controller: passwordConfirmControler,
                      obscureText: !isVisibleConfirm,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscuringCharacter: '*',
                      onChanged: verifyConfirmPassword,
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.75),
                        filled: true,
                        hintText: '**********************',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisibleConfirm = !isVisibleConfirm;
                            });
                          },
                          icon: Icon(
                            isVisibleConfirm
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        errorText: errorPasswordConfirm.isEmpty
                            ? null
                            : errorPasswordConfirm,
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
            // Container(
            //   margin: const EdgeInsets.only(top: 20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.only(bottom: 10),
            //         child: Text(
            //           'CPF',
            //           style: GoogleFonts.outfit(
            //             color: Colors.black,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 56,
            //         child: TextFormField(
            //           controller: cpfControler,
            //           onChanged: (value) {
            //             String newValue;

            //             if (value.length >= 6 && value.length < 9) {
            //               newValue = value.replaceAllMapped(
            //                   RegExp(r'(\d{3})(\d{3})'), (match) {
            //                 return '${match[1]}.${match[2]}';
            //               });

            //               cpfControler.value = TextEditingValue(
            //                 text: newValue,
            //                 selection: TextSelection.fromPosition(
            //                   TextPosition(offset: newValue.length),
            //                 ),
            //               );
            //             } else if (value.length >= 9 &&
            //                 value.length < 11) {
            //               newValue = value.replaceAllMapped(
            //                   RegExp(r'(\d{3})(\d{3})(\d{3})'), (match) {
            //                 return '${match[1]}.${match[2]}.${match[3]}';
            //               });

            //               cpfControler.value = TextEditingValue(
            //                 text: newValue,
            //                 selection: TextSelection.fromPosition(
            //                   TextPosition(offset: newValue.length),
            //                 ),
            //               );
            //             } else if (value.length == 11) {
            //               newValue = value.replaceAllMapped(
            //                   RegExp(r'(\d{3})(\d{3})(\d{3})((\d{1,2}))'),
            //                   (match) {
            //                 return '${match[1]}.${match[2]}.${match[3]}-${match[4]}';
            //               });

            //               cpfControler.value = TextEditingValue(
            //                 text: newValue.substring(0, 14),
            //                 selection: TextSelection.fromPosition(
            //                   TextPosition(offset: newValue.length),
            //                 ),
            //               );
            //             }
            //           },

            //           decoration: InputDecoration(
            //             hintText: '000.000.000-00',
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30),
            //               borderSide: const BorderSide(
            //                 width: 2,

            //               ),
            //             ),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30),
            //               borderSide: const BorderSide(

            //               ),
            //             ),
            //           ),
            //           inputFormatters: [
            //             FilteringTextInputFormatter(
            //               RegExp('[0-9]'),
            //               allow: true,
            //             ),
            //             LengthLimitingTextInputFormatter(11),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Container(
            //   margin: const EdgeInsets.only(top: 20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.only(bottom: 10),
            //         child: Text(
            //           'Código Postal',
            //           style: GoogleFonts.outfit(
            //             color: Colors.black,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 56,
            //         child: TextFormField(
            //           controller: zipcodeUserController,

            //           autofillHints: const [AutofillHints.email],
            //           onChanged: (value) async {
            //             String newValue;

            //             if (value.length == 5) {
            //               newValue = value.replaceAllMapped(
            //                   RegExp(r'^(\d{5})'), (match) {
            //                 return '${match[1]}';
            //               });

            //               zipcodeUserController.value = TextEditingValue(
            //                 text: newValue,
            //                 selection: TextSelection.fromPosition(
            //                   TextPosition(offset: newValue.length),
            //                 ),
            //               );
            //             } else if (value.length == 8) {
            //               newValue = value.replaceAllMapped(
            //                   RegExp(r'^(\d{5})(\d{3})'), (match) {
            //                 return '${match[1]}-${match[2]}';
            //               });

            //               zipcodeUserController.value = TextEditingValue(
            //                 text: newValue,
            //                 selection: TextSelection.fromPosition(
            //                   TextPosition(offset: newValue.length),
            //                 ),
            //               );

            //               final data = await getAddress(
            //                 zipcodeUserController.text,
            //               );

            //               cityUserController.value = TextEditingValue(
            //                 text: data['logradouro'].toString(),
            //               );
            //             }
            //           },
            //           decoration: InputDecoration(
            //             hintText: '00000-000',
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30),
            //               borderSide: const BorderSide(
            //                 width: 2,

            //               ),
            //             ),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30),
            //               borderSide: const BorderSide(

            //               ),
            //             ),
            //           ),
            //           inputFormatters: [
            //             FilteringTextInputFormatter(
            //               RegExp('[0-9]'),
            //               allow: true,
            //             ),
            //             LengthLimitingTextInputFormatter(8),
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.only(top: 20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.only(bottom: 10),
            //         child: Text(
            //           'Cidade',
            //           style: GoogleFonts.outfit(
            //             color: Colors.black,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 56,
            //         child: TextFormField(
            //           controller: cityUserController,

            //           autofillHints: const [AutofillHints.email],
            //           decoration: InputDecoration(
            //             hintText: 'Cidade',
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30),
            //               borderSide: const BorderSide(
            //                 width: 2,

            //               ),
            //             ),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30),
            //               borderSide: const BorderSide(

            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.only(top: 20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.only(bottom: 10),
            //         child: Text(
            //           'Estado',
            //           style: GoogleFonts.outfit(
            //             color: Colors.black,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 56,
            //         child: TextFormField(
            //           controller: ufUserController,

            //           autofillHints: const [AutofillHints.email],
            //           onChanged: (value) {
            //             ufUserController.value = TextEditingValue(
            //               text: value.toUpperCase(),
            //               selection: TextSelection.fromPosition(
            //                 TextPosition(offset: value.length),
            //               ),
            //             );
            //           },
            //           decoration: InputDecoration(
            //             hintText: 'Estado',
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30),
            //               borderSide: const BorderSide(
            //                 width: 2,

            //               ),
            //             ),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30),
            //               borderSide: const BorderSide(

            //               ),
            //             ),
            //           ),
            //           inputFormatters: [
            //             LengthLimitingTextInputFormatter(2),
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.only(top: 20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.only(bottom: 10),
            //         child: Text(
            //           'Endereço',
            //           style: GoogleFonts.outfit(
            //             color: Colors.black,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 56,
            //         child: TextFormField(
            //           controller: addressUserController,

            //           autofillHints: const [AutofillHints.email],
            //           decoration: InputDecoration(
            //             hintText: 'Endereço',
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30),
            //               borderSide: const BorderSide(
            //                 width: 2,

            //               ),
            //             ),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30),
            //               borderSide: const BorderSide(

            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.only(top: 20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.only(bottom: 10),
            //         child: Text(
            //           'Bairro',
            //           style: GoogleFonts.outfit(
            //             color: Colors.black,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 56,
            //         child: TextFormField(
            //           controller: districtUserController,

            //           autofillHints: const [AutofillHints.email],
            //           decoration: InputDecoration(
            //             hintText: 'Bairro',
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30),
            //               borderSide: const BorderSide(
            //                 width: 2,

            //               ),
            //             ),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(30),
            //               borderSide: const BorderSide(

            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            InkWell(
              onTap: () async {
                // if (emailControler.text.isNotEmpty &&
                //     phoneController.text.isNotEmpty &&
                //     passwordControler.text.isNotEmpty &&
                //     passwordConfirmControler.text.isNotEmpty &&
                //     nameController.text.isNotEmpty) {
                //   if (passwordControler.text == passwordConfirmControler.text) {
                //     if (!isLoading) {
                //       setState(() {
                //         isLoading = true;
                //       });

                //       Response response = await AuthRepo.signUser(
                //         emailControler.text,
                //         passwordControler.text,
                //         nameController.text,
                //         phoneController.text,
                //       );

                //       if (response.data.containsKey("jwt") == true) {
                //         await DB().setUserdata(
                //             emailControler.text, passwordControler.text, false);
                //         await saveUserToken(
                //           response.data['jwt'].toString(),
                //         );
                //         isLoading = false;
                //         setState(() {
                //           userData.setUserData(
                //             response.data as Map<String, dynamic>,
                //           );
                //         });
                //         await Get.to(const HomePage());
                //       } else {
                //         ElegantNotification.error(
                //           description: Text(
                //             response.data["Message"],
                //           ),
                //         ).show(context);
                //       }
                //     } else {
                //       ElegantNotification.error(
                //         description: const Text(
                //           'Preencha todos os campos, por favor',
                //         ),
                //       ).show(context);
                //     }
                //   }
                // } else {
                //   ElegantNotification.error(
                //     description: const Text(
                //       'Preencha todos os campos, por favor',
                //     ),
                //   ).show(context);
                // }
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
                        color: mainSecondayColor,
                      )
                    : Text(
                        'Cadastrar',
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
                Get.off(() => const LoginPage());
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'Já tem conta? Entre!',
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
    );
  }
}
