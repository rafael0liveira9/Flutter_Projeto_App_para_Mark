// import 'package:astros_app/config/ENV/DEV.dart';
import 'package:dio/dio.dart';
import 'package:Mark/config/ENV/PROD.dart';

BaseOptions options = BaseOptions(
  baseUrl: API,
);

Dio api = Dio(options);
