import 'package:Mark/config/api.dart';

class AuthRepo {
  static Future loginUser(email, password) async {
    return await api.post("/auth/signin/", data: {
      "email": email,
      "password": password,
    });
  }
}
