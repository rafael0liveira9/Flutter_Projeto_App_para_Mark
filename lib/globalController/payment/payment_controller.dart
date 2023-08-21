import 'package:Mark/models/paymentModels/package_model.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  RxList<PackageModel> packagesSearched = <PackageModel>[].obs;
  RxList<PackageModel> packagesSelected = <PackageModel>[].obs;

  RxString creditNumber = "".obs;
  RxString cvcNumber = "".obs;
  RxString userName = "".obs;
  RxString valid = "".obs;
}
