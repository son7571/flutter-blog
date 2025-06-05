import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/utils/my_http.dart';
import 'package:flutter_blog/data/repository/user_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_blog/ui/pages/auth/join_page/join_fm.dart';
import 'package:flutter_blog/ui/pages/auth/login_page/login_fm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// 1. 창고 관리자
final sessionProvider = NotifierProvider<SessionGvm, SessionModel>(() {
  return SessionGvm();
});

/// 2. 창고 (상태가 변경되어도, 화면 갱신 안함 - watch 하지마)
class SessionGvm extends Notifier<SessionModel> {
  final mContext = navigatorKey.currentContext!;

  @override
  SessionModel build() {
    return SessionModel();
  }

  Future<void> join(String username, String email, String password) async {
    Logger()
        .d("username : ${username}, email : ${email}, password : ${password}");
    bool IsValid = ref.read(joinProvider.notifier).validate();
    if (!IsValid) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("유효성 검사 실패 입니다")),
      );
    }

    Map<String, dynamic> body =
        await UserRepository().join(username, email, password);
    if (!body["success"]) {
      //토스트 뛰우기
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${body["errorMessage"]}")),
      );
      return;
    }

    Navigator.pushNamed(mContext, "/login");
  }

  Future<void> login(String username, String password) async {
    // 1. 유효성 검사
    Logger().d("username : ${username}, password : ${password}");
    bool isValid = ref.read(loginProvider.notifier).validate();
    if (!isValid) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("유효성 검사 실패입니다")),
      );
      return;
    }

    // 2. 통신
    Map<String, dynamic> body =
        await UserRepository().login(username, password);
    if (!body["success"]) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${body["errorMessage"]}")),
      );
      return;
    }

    // 3. 토큰을 디바이스 저장
    await secureStorage.write(
        key: "accessToken", value: body["response"]["accessToken"]);

    // 4. 세션모델 갱신
    state = SessionModel(
        id: body["response"]["id"],
        username: body["response"]["username"],
        imgUrl: body["response"]["imgUrl"],
        accessToken: body["response"]["accessToken"],
        isLogin: true);

    // 5. dio의 header에 토큰 세팅
    dio.options.headers["Authorization"] = body["response"]["accessToken"];

    // 6. 게시글 목록 페이지 이동
    Navigator.pushNamed(mContext, "/post/list");
  }

  Future<void> logout(String username, String email, String password) async {}
}

/// 3. 창고 데이터 타입
class SessionModel {
  int? id;
  String? username;
  String? imgUrl;
  String? accessToken;
  bool? isLogin;

  SessionModel(
      {this.id,
      this.username,
      this.imgUrl,
      this.accessToken,
      this.isLogin = false});
}
