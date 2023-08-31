import 'package:Mark/config/api.dart';

class AuthRepo {
  static Future loginUser(email, password) async {
    return await api.post("/auth/signin/", data: {
      "email": email,
      "password": password,
    });
  }

  static Future signUser(
      {String? email, String? password, String? name, String? phone}) async {
    return await api.post("/auth/signup", data: {
      "email": email,
      "password": password,
      "name": name,
      "phone": phone,
      "document": "708.555.324-32",
      "documentType": "CPF",
      "firebaseToken": "123123123",
      "cep": "59285384"
    });
  }
}
