// import 'package:chat_app/presentation/chat/view/chat_de_prueba.txt';
import 'package:chat_app/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../presentation/chat/view/chat_screen.dart';
import '../../presentation/home/view/home_screen.dart';
import '../../presentation/login/view/login_screen.dart';

class RoutesApp {
  static const String login = 'login';
  static const String home = 'home';
  static const String chat = 'chat';
  static const String chatPrueba = 'chat-prueba';
  static const String splash = 'splash';

  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    chat: (context) => const ChatScreen(),
    // chatPrueba: (context) => const ChatDePruebaScreen()
  };
}
