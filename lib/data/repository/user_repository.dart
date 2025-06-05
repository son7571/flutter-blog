import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/utils/my_http.dart';
import 'package:logger/logger.dart';

class UserRepository {
  Future<Map<String, dynamic>> join(
      String username, String email, String password) async {
    final requestBody = {
      "username": username,
      "email": email,
      "password": password,
    };
    Response response = await dio.post("/join", data: requestBody);
    final responseBody = response.data;
    Logger().d(responseBody);
    return responseBody;
  }

  // 1. Map 변환
  Future<Map<String, dynamic>> login(String username, String password) async {
    final requestBody = {
      "username": username,
      "password": password,
    };

    // 2. 통신
    Response response = await dio.post("/login", data: requestBody);
    final responseBody = response.data;

    // 3. 헤더에서 토큰을 꺼내야됨
    String accessToken = "";
    try {
      accessToken = response.headers["Autorization"]![0];
      responseBody["response"]["accessToken"] = accessToken;
    } catch (e) {}
    Logger().d(responseBody);

    return responseBody;
  }
}
