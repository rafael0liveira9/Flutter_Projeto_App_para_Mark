import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:Mark/config/repo/auth_repo.dart';
import 'package:Mark/globalController/user_controller.dart';
import 'package:Mark/pages/account/login/view/login_page.dart';
import 'package:Mark/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  Database? db;

  final userController = Get.put<UserController>(
    UserController(),
  );

  Future<dynamic> openDbUser() async {
    db = await openDatabase(
      'user_db.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        create table user(
          id integer primary key autoincrement,
          email text not null UNIQUE,
          password text,
          integrationtoken text,
          loggeddate text
        )
        ''');
      },
    );
  }

  Future<dynamic> getUserData() async {
    await openDbUser();
    if (db!.isOpen) {
      final List<Map> userData = await db!.query('user');
      if (userData.isNotEmpty) {
        return userData[0];
      } else {
        return userData;
      }
    }
  }

  Future<dynamic> setUserdata(
      String email, String password, bool isIntegration) async {
    await openDbUser();
    if (db!.isOpen) {
      await db!.insert(
        'user',
        {
          'email': email,
          'password': isIntegration ? '' : password,
          'integrationtoken': isIntegration ? password : '',
          'loggeddate': DateTime.now().toString(),
        },
      );
    }
  }

  Future<dynamic> loginUser() async {
    await openDbUser();
    if (db!.isOpen) {
      final List<Map> userData = await db!.query('user');
      if (userData.isNotEmpty) {
        try {
          Response response = await AuthRepo.loginUser(
            userData[0]['email'].toString(),
            userData[0]['password'],
          );

          await saveUserToken(response.data['jwt'].toString());

          userController.setUserData(
            response.data as Map<String, dynamic>,
          );

          await db!.update(
            'user',
            {
              'email': userData[0]['email'],
              'password': userData[0]['password'],
              'loggeddate': DateTime.now().toString(),
            },
          );
        } on DioException catch (e) {
          print(e);
          Get.to(const LoginPage());
        }
      } else {
        return userData;
      }
    }
  }

  Future<dynamic> logoutUser() async {
    await openDbUser();
    if (db!.isOpen) {
      await deleteUser();
      userController.setUserData(
        {},
      );
      // Get.to(const OnboardingScreen());
    }
  }

  Future<dynamic> deleteUser() async {
    await openDbUser();
    if (db!.isOpen) {
      await db!.delete('user');
    }
  }
}
