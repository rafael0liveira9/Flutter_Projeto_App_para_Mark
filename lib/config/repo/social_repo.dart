import 'package:Mark/config/api.dart';
import 'package:Mark/globalController/user_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class SocialRepo {
  static Future sendBriefing(Map data) async {
    final userData = Get.put<UserController>(UserController());
    return await api.post(
      "/briefing/social",
      data: data,
      options: Options(headers: {
        "Authorization": userData.userdata.value?.token,
      }),
    );
  }

  static Future updateShow(Map data) async {
    final userData = Get.put<UserController>(UserController());

    return await api.put(
      "/social/update-show",
      data: data,
      options: Options(headers: {
        "Authorization": userData.userdata.value?.token,
      }),
    );
  }

  static Future updateFinalShow(Map data) async {
    final userData = Get.put<UserController>(UserController());

    return await api.put(
      "/social/update-approve",
      data: data,
      options: Options(headers: {
        "Authorization": userData.userdata.value?.token,
      }),
    );
  }
}
