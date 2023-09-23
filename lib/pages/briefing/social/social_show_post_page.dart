import 'package:Mark/models/contratedModels/social_contrated_item_model.dart';
import 'package:Mark/pages/briefing/social/social_reject_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/social_controller.dart';

class SocialShowPostPage extends StatefulWidget {
  const SocialShowPostPage({super.key, required this.showData});
  final SocialFeedModel showData;

  @override
  State<SocialShowPostPage> createState() => _SocialShowPostPageState();
}

class _SocialShowPostPageState extends State<SocialShowPostPage>
    with TickerProviderStateMixin {
  bool isFinished = false, isLoading = false;

  final socialController = Get.put<SocialController>(SocialController());
  late TabController controller;
  TextEditingController comments = TextEditingController();
  TextEditingController text = TextEditingController();
  SocialFeedModel? showData;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    showData = widget.showData;
    comments = TextEditingController(text: widget.showData.comments);
    text = TextEditingController(text: widget.showData.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              "Redes Sociais",
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
              onTap: () {
                // Get.to(const LogoStatusPage());
              },
              child: Container(
                width: 93,
                height: 30,
                decoration: BoxDecoration(
                  // color: networkType.text.isNotEmpty &&
                  //         serviceType.text.isNotEmpty &&
                  //         imageBase.text.isNotEmpty &&
                  //         materialQuant.text.isNotEmpty &&
                  //         hoursDays.text.isNotEmpty &&
                  //         midiaFormat.text.isNotEmpty &&
                  //         midiaFormat.text.split(",").length >= 3
                  //     ? mainSecondayColor
                  //     : const Color(0xFf1f1f1f).withOpacity(
                  //         0.12,
                  //       ),
                  borderRadius: BorderRadius.circular(
                    100,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "SALVAR",
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    // color: networkType.text.isNotEmpty &&
                    //         serviceType.text.isNotEmpty &&
                    //         imageBase.text.isNotEmpty &&
                    //         materialQuant.text.isNotEmpty &&
                    //         hoursDays.text.isNotEmpty &&
                    //         midiaFormat.text.isNotEmpty &&
                    //         midiaFormat.text.split(",").length >= 3
                    //     ? Colors.white
                    //     : neutralTen.withOpacity(0.38),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
            child: Text(
              "Publicação 1/15",
              style: GoogleFonts.roboto(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: neutralTen,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sua Empresa",
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: neutralTen,
                                ),
                              ),
                              const Text("Patrocinado"),
                            ],
                          )
                        ],
                      ),
                      const Icon(Icons.more_horiz)
                    ],
                  ),
                ),
                Container(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width,
                            child: FadeInImage(
                              placeholder: const AssetImage(
                                "assets/images/rectangleOrange.png",
                              ),
                              image: NetworkImage(
                                showData?.Images?.url ?? "",
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
                          Opacity(
                            opacity: 0.5,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 10, bottom: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Get.defaultDialog(
                              titlePadding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              titleStyle: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  color: neutralThree,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              title: "Comentários",
                              content: StatefulBuilder(
                                builder: (context, state) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20),
                                              child: TextFormField(
                                                cursorColor: mainPrimaryColor,
                                                controller: comments,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                decoration: InputDecoration(
                                                  fillColor: mainPrimaryColor
                                                      .withOpacity(0.11),
                                                  filled: true,
                                                  suffixIcon: comments
                                                          .text.isNotEmpty
                                                      ? IconButton(
                                                          icon: const Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            color: neutralTen,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              comments.text =
                                                                  "";
                                                            });
                                                          },
                                                        )
                                                      : null,
                                                  labelStyle:
                                                      GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      color: neutralThree,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  labelText:
                                                      "Comente algo sobre a postagem",
                                                  border:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: neutralSix,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: neutralTen,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 40, bottom: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 30),
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Voltar",
                                                    style: GoogleFonts.roboto(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: neutralThree,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                child: InkWell(
                                                  onTap: () {
                                                    showData?.comments =
                                                        comments.text;
                                                    setState(() {});
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Salvar",
                                                    style: GoogleFonts.roboto(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: mainPrimaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chat,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              spacing: 10,
                              alignment: WrapAlignment.center,
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/icons/comm.png"),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/icons/share.png"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Get.defaultDialog(
                                    titlePadding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    titleStyle: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        color: neutralThree,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    title: "Editar Texto",
                                    content: StatefulBuilder(
                                      builder: (context, state) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: TextFormField(
                                                      cursorColor:
                                                          mainPrimaryColor,
                                                      controller: text,
                                                      onChanged: (value) {
                                                        setState(() {});
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor:
                                                            mainPrimaryColor
                                                                .withOpacity(
                                                                    0.11),
                                                        filled: true,
                                                        suffixIcon: text
                                                                .text.isNotEmpty
                                                            ? IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .cancel_outlined,
                                                                  color:
                                                                      neutralTen,
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    text.text =
                                                                        "";
                                                                  });
                                                                },
                                                              )
                                                            : null,
                                                        labelStyle:
                                                            GoogleFonts.roboto(
                                                          textStyle:
                                                              const TextStyle(
                                                            color: neutralThree,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        labelText:
                                                            "Edite o texto da postagem",
                                                        border:
                                                            const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: neutralSix,
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: neutralTen,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 40, bottom: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 30),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          "Voltar",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            textStyle:
                                                                const TextStyle(
                                                              color:
                                                                  neutralThree,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: InkWell(
                                                        onTap: () {
                                                          showData?.text =
                                                              text.text;
                                                          setState(() {});
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          "Salvar",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            textStyle:
                                                                const TextStyle(
                                                              color:
                                                                  mainPrimaryColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ));
                              },
                              child: SizedBox(
                                height: 20,
                                child: Text(
                                  "Editar Legenda",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: neutralTen,
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
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: RichText(
                    text: TextSpan(
                      text: "Sua Empresa ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                      children: [
                        TextSpan(
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                          text: showData?.text ?? "",
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    SocialFeedModel copy = showData ?? widget.showData;
                    copy.approved = false;
                    print(copy);
                    Get.to(SocialRejectPage(social: copy));
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
                      "Recusar",
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
                    // await sendFeedback();
                    SocialFeedModel copy = showData ?? widget.showData;
                    copy.approved = true;
                    print(copy);
                    Get.back(result: copy);
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
    );
  }
}
