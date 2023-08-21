// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:get/get.dart';
import 'package:Mark/models/socialModels/network_models.dart';

class SocialController extends GetxController {
  RxList<NetworkTypeModel> networkTypes = <NetworkTypeModel>[
    NetworkTypeModel(name: "Facebook", value: "FACEBOOK"),
    NetworkTypeModel(name: "Instagram", value: "INSTAGRAM"),
    NetworkTypeModel(name: "TikTok", value: "TIKTOK"),
    NetworkTypeModel(name: "Youtube", value: "YOUTUBE"),
    NetworkTypeModel(name: "Linkedin", value: "LINKEDIN"),
  ].obs;
}
