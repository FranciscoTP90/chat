import 'package:chat_app/core/blocs/socket/socket_bloc.dart';
import 'package:chat_app/core/routes/routes_app.dart';
import 'package:chat_app/presentation/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<LoginBloc>().add(LoginEvent.onGetUserByToken());
      }
    });
  }

  // Future<String?> getToken() async {
  //   try {
  //     final String? token = await context.read<LoginBloc>().getToken();
  //     return token;
  //   } catch (e) {
  //     throw "$e";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: BLOC CONSUMER Y EN EL LISTENER MANDAR A LA OTRA PANTALLA
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state.tokenStatus == UserByTokenStatus.loading ||
              state.tokenStatus == UserByTokenStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.tokenStatus == UserByTokenStatus.error) {
            Future.microtask(() {
              context.read<SocketBloc>().add(SocketEvent.onDisconnectSocket());
              Navigator.pushReplacementNamed(context, RoutesApp.login);
            });
            return const SizedBox.shrink();
          }
          Future.microtask(() {
            // Navigator.pushReplacementNamed(context, RoutesApp.home);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen(token: state.userModel!.token),
                ));
          });
          return const SizedBox.shrink();
        },
      ),
      // body: FutureBuilder<String?>(
      //   future: getToken(),
      //   builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.hasData) {
      //         Future.microtask(() {
      //           // Navigator.pushReplacementNamed(context, RoutesApp.home);
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => HomeScreen(token: snapshot.data),
      //               ));
      //         });
      //         return const SizedBox.shrink();
      //       } else {
      //         Future.microtask(() {
      //           context
      //               .read<SocketBloc>()
      //               .add(SocketEvent.onDisconnectSocket());
      //           Navigator.pushReplacementNamed(context, RoutesApp.login);
      //         });

      //         return const SizedBox.shrink();
      //       }
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
