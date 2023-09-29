import 'package:Mark/config/api.dart';
import 'package:Mark/globalController/user_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class PackagesRepo {
  static Future searchPackages(
    double value,
    bool haveLogo,
    bool haveSite,
    bool haveSocialMedia,
  ) async {
    UserController userData = Get.put<UserController>(UserController());

    return api.post(
      "/package/search",
      data: {
        "value": value,
        "haveLogo": haveLogo,
        "haveSite": haveSite,
        "haveSocialMidia": haveSocialMedia
      },
      options: Options(
        headers: {
          "Authorization": userData.userdata.value?.token,
        },
      ),
    );
  }
}
