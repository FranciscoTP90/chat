import 'package:chat_app/core/blocs/socket/socket_bloc.dart';
import 'package:chat_app/core/routes/routes_app.dart';
import 'package:chat_app/core/theme/theme_app.dart';
import 'package:chat_app/data/data_providers/local/secure_storage_provider.dart';
import 'package:chat_app/data/data_providers/remote/dio_provider.dart';
import 'package:chat_app/data/data_repositories/chat_repository.dart';
import 'package:chat_app/presentation/chat/bloc/chat_bloc.dart';
import 'package:chat_app/presentation/home/bloc/home_bloc.dart';
import 'package:chat_app/presentation/login/bloc/login_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatAppState extends StatelessWidget {
  const ChatAppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => ChatRepository(
                iRemoteDataProvider: DioDataProvider(client: Dio()),
                iLocalProvider: SecureStorageProvider(
                    storage: const FlutterSecureStorage())),
          )
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) =>
                LoginBloc(context.read<ChatRepository>())..init(),
          ),
          BlocProvider(
            create: (context) => SocketBloc(),
          ),
          BlocProvider(
              create: (context) => HomeBloc(context.read<ChatRepository>())),
          BlocProvider(
            create: (context) => ChatBloc(context.read<ChatRepository>()),
          )
        ], child: const ChatApp()));
  }
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: RoutesApp.splash,
      routes: RoutesApp.routes,
      theme: ThemeApp.themeLight,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
