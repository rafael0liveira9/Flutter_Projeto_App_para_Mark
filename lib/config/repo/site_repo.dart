import 'package:Mark/config/api.dart';
import 'package:Mark/globalController/user_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class SiteRepo {
  static Future sendBriefing(Map data) async {
    final userData = Get.put<UserController>(UserController());
    return await api.post(
      "/briefing/site",
      data: data,
      options: Options(headers: {
        "Authorization": userData.userdata.value?.token,
      }),
    );
  }

  static Future updateToShow(
    int serviceId,
    int imageId,
  ) async {
    final userData = Get.put<UserController>(UserController());

    return await api.put(
      "/site/to-show",
      data: {
        "id": serviceId,
        "imageId": imageId,
      },
      options: Options(headers: {
        "Authorization": userData.userdata.value?.token,
      }),
    );
  }

  static Future updateSaveShow(
    int serviceId,
  ) async {
    final userData = Get.put<UserController>(UserController());

    return await api.put(
      "/site/save-show",
      data: {
        "id": serviceId,
      },
      options: Options(headers: {
        "Authorization": userData.userdata.value?.token,
      }),
    );
  }

  static Future updateApprove(
      int serviceId, bool isApproved, String refuseReason) async {
    final userData = Get.put<UserController>(UserController());

    return await api.put(
      "/site/approve-layout",
      data: {
        "id": serviceId,
        "isApproved": isApproved,
        "refuseReason": refuseReason,
      },
      options: Options(headers: {
        "Authorization": userData.userdata.value?.token,
      }),
    );
  }
}
