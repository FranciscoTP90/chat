// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

// {
//     "email":"jaxogag969@wwgoc.com",
//     "password":"123456",
//     "name":"User 3"
// }

enum LoginStatus { initial, loading, success, error }

enum UserByTokenStatus { initial, loading, success, error }

// class ErrorResp {
//   final String code;
//   final String msg;
//   ErrorResp({
//     required this.code,
//     required this.msg,
//   });
// }

class LoginState extends Equatable {
  const LoginState(
      {required this.status,
      required this.rememberMe,
      this.error,
      this.userModel,
      required this.tokenStatus});

  final LoginStatus status;
  final bool rememberMe;
  // final String email;
  // final String password;
  final UserModel? userModel;
  final String? error;
  final UserByTokenStatus tokenStatus;

  factory LoginState.initialState() => const LoginState(
      status: LoginStatus.initial,
      rememberMe: true,
      error: null,
      userModel: null,
      tokenStatus: UserByTokenStatus.initial);

  @override
  List<dynamic> get props =>
      [status, rememberMe, error, userModel, tokenStatus];

  LoginState copyWith(
      {LoginStatus? status,
      bool? rememberMe,
      String? error,
      UserModel? userModel,
      UserByTokenStatus? tokenStatus}) {
    return LoginState(
        status: status ?? this.status,
        rememberMe: rememberMe ?? this.rememberMe,
        error: error ?? this.error,
        userModel: userModel ?? this.userModel,
        tokenStatus: tokenStatus ?? this.tokenStatus);
  }
}
