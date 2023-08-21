import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/social_controller.dart';

class SocialShowPage extends StatefulWidget {
  const SocialShowPage({super.key});

  @override
  State<SocialShowPage> createState() => _SocialShowPageState();
}

class _SocialShowPageState extends State<SocialShowPage>
    with TickerProviderStateMixin {
  bool isFinished = false;

  final socialController = Get.put<SocialController>(SocialController());
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
            child: Text(
              "Amostra de Textos",
              style: GoogleFonts.roboto(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: neutralTen,
              ),
            ),
          ),
          TabBar(
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            controller: controller,
            labelColor: Colors.black,
            tabs: const [
              Tab(
                icon: Icon(Icons.grid_on_rounded),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.video),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.person),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              physics: const ScrollPhysics(),
              children: [
                Container(
                  child: Wrap(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            child: const Icon(
                              Icons.personal_video,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            child: const Icon(
                              Icons.personal_video,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            child: const Icon(
                              Icons.personal_video,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(),
                Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
