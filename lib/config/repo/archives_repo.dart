import 'package:Mark/config/api.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/globalController/user_controller.dart';
import 'package:dio/dio.dart';

import 'package:get/instance_manager.dart';

class ArchivesRepo {
  static Future sendArchives({FormData? data}) async {
    final userData = Get.put<UserController>(UserController());
    final serviceController = Get.put<ServiceController>(ServiceController());
    Response returnData = await api.post(
      "/send-media/archive",
      data: data,
      queryParameters: {"companieId": serviceController.companieId.value},
      options: Options(
        headers: {"Authorization": userData.userdata.value?.token},
      ),
    );
    return returnData;
  }
}
