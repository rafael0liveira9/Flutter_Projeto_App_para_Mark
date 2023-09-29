import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:Mark/config/api.dart';
import 'package:Mark/globalController/user_controller.dart';

class LogoRepo {
  static Future sendBriefing(
      int companieId,
      int id,
      String title,
      String subtitle,
      String format,
      List colors,
      String typography,
      String especification,
      String references,
      String description) async {
    final userData = Get.put<UserController>(UserController());

    return await api.post(
      "/briefing/logo",
      data: {
        "companieId": companieId,
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "format": format,
        "cores": colors,
        "typography": typography,
        "especification": especification,
        "references": references,
        "description": description,
      },
      options: Options(headers: {
        "Authorization": userData.userdata.value?.token,
      }),
    );
  }

  static Future updateProof(
      int serviceId, int proofId, bool isApproved, String? reasonRefuse) async {
    final userData = Get.put<UserController>(UserController());

    return await api.put(
      "/logo/to-proof",
      data: {
        "id": serviceId,
        "proof": proofId,
        "reasonRefuse": reasonRefuse,
        "isApproved": isApproved,
      },
      options: Options(headers: {
        "Authorization": userData.userdata.value?.token,
      }),
    );
  }

  static Future sendFeedback(
      int serviceId, double stars, String? comments) async {
    final userData = Get.put<UserController>(UserController());

    return await api.put(
      "/logo/send-feedback",
      data: {"id": serviceId, "comments": comments, "stars": stars},
      options: Options(headers: {
        "Authorization": userData.userdata.value?.token,
      }),
    );
  }
}
