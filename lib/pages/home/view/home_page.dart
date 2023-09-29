import 'package:Mark/db/user_db.dart';
import 'package:Mark/pages/services/logo/logo_services_page.dart';
import 'package:Mark/pages/services/site/site_services_page.dart';
import 'package:Mark/pages/services/social/social_services_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/config/repo/services_repo.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/globalController/user_controller.dart';
import 'package:Mark/models/contrated_services_model.dart';
import 'package:Mark/utils/utils.dart';
import 'package:Mark/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  final userData = Get.put<UserController>(UserController());
  final serviceController = Get.put<ServiceController>(ServiceController());
  ContratedServiceModel? contratedServices;
  List contrateds = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await servicesContrated();
    });
  }

  Future servicesContrated() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await ServicesRepo.getServicesContrated();
      ContratedServiceModel contratedService =
          ContratedServiceModel.fromMap(response.data);
      List data = [];

      for (var i = 0; i < contratedService.LogoContratedItems.length; i++) {
        data.add(contratedService.LogoContratedItems[i]);
      }
      // for (var i = 0; i < contratedService.SiteContratedItems.length; i++) {
      //   data.add(contratedService.SiteContratedItems[i]);
      // }
      // for (var i = 0; i < contratedService.SocialContratedItems.length; i++) {
      //   data.add(contratedService.SocialContratedItems[i]);
      // }

      setState(() {
        contrateds = sliceArray(data);
        contratedServices = contratedService;
        serviceController.companieId.value = contratedService.companieId;
        isLoading = false;
      });
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.response?.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      key: scaffoldKey,
      appBar: AppBarCustom(context),
      drawer: Container(
        width: 300,
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            20,
            MediaQuery.of(context).padding.top,
            20,
            MediaQuery.of(context).padding.bottom,
          ),
          children: [
            ElevatedButton(
              onPressed: () async {
                await DB().logoutUser();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: mainPrimaryColor,
                surfaceTintColor: mainPrimaryColor,
              ),
              child: Text(
                "Sair da Conta",
                style: GoogleFonts.roboto(
                  color: neutralTen,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      // bottomNavigationBar: const BottomBarCustom(),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await servicesContrated();
            },
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Olá, ${userData.userdata.value?.name}",
                              style: GoogleFonts.roboto(
                                color: neutralTen,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              "Acompanhe abaixo de forma resumida o status dos serviços",
                              style: GoogleFonts.roboto(
                                color: neutralTen,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ServiceItemFlex(
                                        type: "Logo",
                                        status: "1",
                                        onTap: () {
                                          Get.to(const LogoServicesPage());
                                        },
                                      ),
                                      ServiceItemFlex(
                                        type: "Social",
                                        status: "1",
                                        onTap: () {
                                          Get.to(const SocialServicesPage());
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ServiceItemFlex(
                                        type: "Site",
                                        status: "1",
                                        onTap: () {
                                          Get.to(const SiteServicesPage());
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.4)),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: mainPrimaryColor,
              ),
            ),
        ],
      ),
    );
  }

  AppBar AppBarCustom(BuildContext context) {
    return AppBar(
      backgroundColor: lightWhite,
      leading: IconButton(
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        icon: const Icon(
          Icons.menu,
          color: neutralTen,
        ),
      ),
      flexibleSpace: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            height: 50,
            child: Image.asset("assets/icons/logo_mark.png"),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: neutralTen,
            ),
          ),
        ),
      ],
    );
  }
}
