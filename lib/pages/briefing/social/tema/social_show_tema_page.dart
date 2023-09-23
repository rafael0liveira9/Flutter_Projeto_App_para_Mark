import 'dart:convert';
import 'dart:math';

import 'package:Mark/config/repo/social_repo.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/models/contratedModels/social_contrated_item_model.dart';
import 'package:Mark/pages/briefing/social/social_show_post_page.dart';
import 'package:Mark/pages/home/view/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/social_controller.dart';

class SocialShowTemaPage extends StatefulWidget {
  const SocialShowTemaPage({super.key, required this.showData});
  final SocialShowModel showData;

  @override
  State<SocialShowTemaPage> createState() => _SocialShowTemaPageState();
}

class _SocialShowTemaPageState extends State<SocialShowTemaPage>
    with TickerProviderStateMixin {
  bool isFinished = false, isLoading = false;

  final socialController = Get.put<SocialController>(SocialController());
  final serviceController = Get.put<ServiceController>(ServiceController());
  late TabController controller;

  SocialShowModel? showData;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    showData = widget.showData;
  }

  @override
  Widget build(BuildContext context) {
    print(showData);
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
              onTap: () async {
                if (!isLoading) {
                  setState(() {
                    isLoading = true;
                  });

                  Map data = {
                    "id": serviceController.serviceId.value,
                    "allApproved": showData!.feed
                        .every((element) => element.approved == true),
                    "isRefused": showData!.feed
                        .any((element) => element.approved == false),
                    "feed": showData!.feed
                        .map((e) => {
                              "id": e.id,
                              "text": e.text,
                              "approved": e.approved,
                              "comments": e.comments,
                              "reasonRefuse": e.reasonRefuse,
                            })
                        .toList(),
                  };

                  print(jsonEncode(data));

                  try {
                    Response response = await SocialRepo.updateShow(data);
                    Get.to(const HomePage());
                  } on DioException catch (e) {
                    print(e.response?.data);
                    setState(() {
                      isLoading = false;
                    });
                  }
                }
              },
              child: Container(
                width: 93,
                height: 30,
                decoration: BoxDecoration(
                  color: showData!.feed
                          .every((element) => element.approved != null)
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
                  "SALVAR",
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: showData!.feed
                            .every((element) => element.approved != null)
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
            child: Text(
              "Aprovação dos Temas",
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
                Wrap(
                  children: [
                    if (showData != null)
                      for (var i = 0; i < showData!.feed.length; i++)
                        InkWell(
                          onTap: () async {
                            final data = await Get.to(SocialShowPostPage(
                              showData: showData!.feed[i],
                            ));

                            if (data != null) {
                              showData!.feed[i] = await data;
                              setState(() {
                                showData!.feed[i];
                              });
                            }
                          },
                          child: Stack(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            showData!.feed[i].Images != null
                                                ? showData!.feed[i].Images!.url
                                                : ""),
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Icon(
                                      showData!.feed[i].approved == false
                                          ? Icons.close
                                          : showData!.feed[i].approved == true
                                              ? Icons.check
                                              : null,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (showData!.feed[i].approved != null ||
                                      showData!.feed[i].Images == null)
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.width / 3,
                                      color: showData!.feed[i].approved == false
                                          ? errorColor.withOpacity(0.7)
                                          : showData!.feed[i].approved == true
                                              ? Colors.green[600]
                                                  ?.withOpacity(0.7)
                                              : Colors.primaries[Random()
                                                  .nextInt(
                                                      Colors.primaries.length)],
                                    ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, right: 10),
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
                  ],
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
