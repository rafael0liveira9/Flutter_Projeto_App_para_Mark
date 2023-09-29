import 'package:Mark/models/contratedModels/social_contrated_item_model.dart';
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

class SocialServicesPage extends StatefulWidget {
  const SocialServicesPage({super.key});

  @override
  State<SocialServicesPage> createState() => _SocialServicesPageState();
}

class _SocialServicesPageState extends State<SocialServicesPage> {
  bool isLoading = true;
  final userData = Get.put<UserController>(UserController());
  final serviceController = Get.put<ServiceController>(ServiceController());
  ContratedServiceModel? contratedServices;
  List contrateds = [];

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
      Response response =
          await ServicesRepo.getServicesContrated(isSocial: true);

      ContratedServiceModel contratedService =
          ContratedServiceModel.fromMap(response.data);
      List data = [];

      for (var i = 0; i < contratedService.SocialContratedItems.length; i++) {
        data.add(contratedService.SocialContratedItems[i]);
      }

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

  final _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBarCustom(context),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 5,
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
                      if (contrateds.isEmpty)
                        const Text("Nenhum dado encontrado"),
                      if (contrateds.isNotEmpty) GroupServices()
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
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
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

  Container GroupServices() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            for (var item in contrateds)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var itemData in item)
                        if (itemData.runtimeType == SocialContratedItem)
                          SocialServiceItemFlex(
                            service: itemData,
                          ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
