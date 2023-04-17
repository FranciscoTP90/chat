// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  factory LoginEvent.onLogin({
    required String email,
    required String password,
    required bool rememberMe,
  }) =>
      _Login(email: email, password: password, rememberMe: rememberMe);

  factory LoginEvent.onRememberMe(bool rememberMe) => _RememberMe(rememberMe);

  factory LoginEvent.onLogOut() => _LogOut();

  factory LoginEvent.onGetUserByToken() => _GetUserByToken();
}

class _Login implements LoginEvent {
  final String email;
  final String password;
  final bool rememberMe;

  _Login({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}

class _RememberMe implements LoginEvent {
  final bool rememberMe;

  _RememberMe(
    this.rememberMe,
  );
}

class _LogOut implements LoginEvent {}

class _GetUserByToken implements LoginEvent {}
