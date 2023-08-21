import 'package:Mark/config/api.dart';
import 'package:Mark/globalController/payment/payment_controller.dart';
import 'package:Mark/globalController/user_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class PaymentRepo {
  static Future checkoutPayment(int installments) async {
    UserController userData = Get.put<UserController>(UserController());
    PaymentController payment = Get.put<PaymentController>(PaymentController());
    print({
      payment.userName,
      payment.creditNumber,
      payment.valid,
      payment.cvcNumber
    });
    return api.post(
      "/payment/checkout",
      data: {
        "package": payment.packagesSelected[0].id,
        "installments": installments,
        "paymentMethod": {
          "creditCard": {
            "holderName": payment.userName.value,
            "number": payment.creditNumber.value,
            "expiryMonth": payment.valid.value.split("/")[0],
            "expiryYear": payment.valid.value.split("/")[1],
            "ccv": payment.cvcNumber.value
          }
        }
      },
      options: Options(
        headers: {
          "Authorization": userData.userdata.value.token,
        },
      ),
    );
  }
}
