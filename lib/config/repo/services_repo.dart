import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:Mark/config/api.dart';
import 'package:Mark/globalController/user_controller.dart';

class ServicesRepo {
  static Future getServicesContrated(
      {bool isLogo = false, bool isSite = false, bool isSocial = false}) async {
    final userData = Get.put<UserController>(UserController());

    return await api.get(
      "/contratedServices?social=$isSocial&logo=$isLogo&site=$isSite",
      options: Options(headers: {
        "Authorization": userData.userdata.value?.token,
      }),
    );
  }
}
