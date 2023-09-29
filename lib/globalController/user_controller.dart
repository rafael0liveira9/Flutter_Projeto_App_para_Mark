import 'package:get/get.dart';
import 'package:Mark/models/user_model.dart';

class UserController extends GetxController {
  final Rxn<UserModel> userdata = Rxn();
  final Rx<int> artistType = 0.obs;

  void setUserData(Map<String, dynamic> userData) {
    userdata.value = UserModel.fromMap(userData);
  }

  UserModel? get getUserdata => userdata.value;
}
