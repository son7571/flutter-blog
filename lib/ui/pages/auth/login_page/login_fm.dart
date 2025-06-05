import 'package:flutter_blog/_core/utils/validator_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 1. 창고 관리자
final loginProvider = NotifierProvider<LoginFM, loginModel>(() {
  return LoginFM();
});

/// 2. 창고
class LoginFM extends Notifier<loginModel> {
  @override
  loginModel build() {
    return loginModel("", "", "", "");
  }

  void username(String username) {
    final error = validateUsername(username);
    print("error : ${error}");
    state = state.copyWith(
      username: username,
      usernameError: error,
    );
  }

  void password(String password) {
    final error = validatePassword(password);
    state = state.copyWith(
      password: password,
      passwordError: error,
    );
  }

  bool validate() {
    final usernameError = validateUsername(state.username);
    final passwordError = validatePassword(state.password);
    return usernameError.isEmpty && passwordError.isEmpty;
  }
}

/// 3. 창고 데이터 타입
class loginModel {
  final String username;
  final String password;

  final String usernameError;
  final String passwordError;

  loginModel(
    this.username,
    this.password,
    this.usernameError,
    this.passwordError,
  );

  loginModel copyWith({
    String? username,
    String? password,
    String? usernameError,
    String? passwordError,
  }) {
    return loginModel(
      username ?? this.username,
      password ?? this.password,
      usernameError ?? this.usernameError,
      passwordError ?? this.passwordError,
    );
  }
}
