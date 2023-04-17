import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/models/login_response.dart';
import 'package:chat_app/domain/repositories/i_chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._iChatRepository) : super(LoginState.initialState()) {
    on<_Login>(_fetchLogin);
    on<_RememberMe>(_rememberMe);
    on<_LogOut>(_logOut);
    on<_GetUserByToken>(_getUserByToken);
  }

  final IChatRepository _iChatRepository;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  void init() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  bool isValidForm() {
    // return formKey.currentState?.validate() ?? false;
    bool validForm = formKey.currentState?.validate() ?? false;
    if (state.status != LoginStatus.loading && validForm) {
      return true;
    } else {
      return false;
    }
  }

  // String? Function(String?)? validator{
  String? emailValidator(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(value ?? '') ? null : 'Ingresa un correo valido';
  }

  String? passwordValidator(String? value) {
    return (value != null && value.length >= 6)
        ? null
        : 'La contraseña debe tener más de 5 caracteres';
  }

  Future<void> _fetchLogin(_Login event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final userModel = await _iChatRepository.fetchLogin(
          email: event.email,
          password: event.password,
          rememberMe: event.rememberMe);
      log("OK: ${userModel.usuario}");
      emit(state.copyWith(status: LoginStatus.success, userModel: userModel));
    } catch (e) {
      log("ERROR:$e");
      emit(state.copyWith(status: LoginStatus.error, error: e.toString()));
    }
  }

  Future<void> _getUserByToken(
      _GetUserByToken event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(tokenStatus: UserByTokenStatus.loading));
      // String token = await _iChatRepository.fetchToken() ?? '';
      final UserModel userModel = await _iChatRepository.fetchUser();
      emit(state.copyWith(
          userModel: userModel, tokenStatus: UserByTokenStatus.success));
    } catch (e) {
      emit(state.copyWith(tokenStatus: UserByTokenStatus.error));
      log("ERROR GET USER BY TOKEN: $e");
    }
  }

  Future<void> _logOut(_LogOut event, Emitter<LoginState> emit) async {
    await _iChatRepository.fetchDeleteToken();
    emit(state.copyWith(
        error: null,
        userModel: null,
        rememberMe: true,
        status: LoginStatus.initial));
  }

  void _rememberMe(_RememberMe event, Emitter<LoginState> emit) {
    emit(state.copyWith(rememberMe: event.rememberMe));
  }

  // Future<String?> getToken() async {
  //   try {
  //     String? token = await _iChatRepository.fetchToken();
  //     if (token != null) {
  //       add(LoginEvent.onGetUserByToken(token));
  //     }
  //     return token;
  //   } catch (e) {
  //     throw "$e";
  //   }
  // }

  // Future<bool> isLoggedIn() async {
  //   try {
  //     String token = await _iChatRepository.fetchToken() ?? '';
  //     // final UserModel userModel = await _iChatRepository.fetchUser(token);
  //     add(LoginEvent.onGetUserByToken(token));
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
