import 'package:chat_app/presentation/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginBloc = context.read<LoginBloc>();
    return BlocConsumer<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        return previous.userModel != current.userModel;
      },
      listenWhen: (previous, current) {
        return previous.userModel != current.userModel;
      },
      listener: (context, state) {
        if (state.error != null && state.status == LoginStatus.error) {
          final snackBar = SnackBar(
              content: Text(state.error!), backgroundColor: Colors.red);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
        if (state.status == LoginStatus.success && state.userModel != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(token: state.userModel!.token),
              ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            actions: const [
              //   DropdownButtonHideUnderline(
              //     child: DropdownButton(
              //   hint: Text(
              //     state.country.toUpperCase(),
              //     style: TextStyle(color: state.appBarItemColor, fontSize: 16),
              //   ),
              //   alignment: Alignment.center,
              //   style: const TextStyle(color: Colors.black),
              //   icon: Icon(
              //     Ionicons.language_outline,
              //     color: state.appBarItemColor,
              //   ),
              //   selectedItemBuilder: (BuildContext context) {
              //     return AppLanguages.values.map((value) {
              //       return Text(
              //         value.name,
              //         style: const TextStyle(color: Colors.white, fontSize: 18),
              //       );
              //     }).toList();
              //   },
              //   items: AppLanguages.values.map<DropdownMenuItem<String>>((e) {
              //     return DropdownMenuItem<String>(
              //         value: e.name, child: CircleAvatar(foregroundImage: AssetImage,) );
              //   }).toList(),
              //   onChanged: (value) {

              //   },
              // ))
            ],
          ),
          body: Container(
            width: size.width,
            height: size.height,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: loginBloc.formKey,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: size.height * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Welcome to Chat App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      const SizedBox(height: 20),
                      const Text("Continue with a Social Network."),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            SocialIcon(
                                icon: Ionicons.logo_google,
                                iconColor: Colors.red),
                            SocialIcon(
                              icon: Ionicons.logo_facebook,
                              iconColor: Colors.blue,
                            ),
                            SocialIcon(
                                icon: Ionicons.logo_apple,
                                iconColor: Colors.grey),
                          ]),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
                          Flexible(
                              child: Divider(
                                  color: Colors.black, endIndent: 10.0)),
                          Text("Or"),
                          Flexible(
                              child: Divider(color: Colors.black, indent: 10)),
                        ],
                      ),

                      const SizedBox(height: 20),
                      _MyTextFormField(
                        text: "Email",
                        icon: Ionicons.mail_outline,
                        controller: loginBloc.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => loginBloc.emailValidator(value),
                      ),
                      _MyTextFormField(
                        text: "Password",
                        icon: Ionicons.lock_closed_outline,
                        controller: loginBloc.passwordController,
                        validator: (value) =>
                            loginBloc.passwordValidator(value),
                      ),

                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            // checkColor: Colors.green,
                            activeColor: Colors.lightGreen,
                            value: state.rememberMe,
                            onChanged: (value) {
                              loginBloc.add(LoginEvent.onRememberMe(value!));
                            },
                          ),
                          const Text(
                            "Remember Me",
                            style: TextStyle(color: Colors.black54),
                          ),
                          const Spacer(),
                          const Text(
                            "Forgot password",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Spacer(),
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 15.0),
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: loginBloc.isValidForm()
                                      ? Colors.yellow
                                      : Colors.grey),
                              onPressed: loginBloc.isValidForm()
                                  ? () {
                                      FocusScope.of(context).unfocus();
                                      loginBloc.add(LoginEvent.onLogin(
                                          email: loginBloc.emailController.text,
                                          password:
                                              loginBloc.passwordController.text,
                                          rememberMe: state.rememberMe));
                                    }
                                  : null,
                              child: const Text("Log In"))),
                      // const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        alignment: Alignment.center,
                        child: RichText(
                            text: const TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16.0),
                                children: [
                              TextSpan(
                                  text: "Sign up for free",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0))
                            ])),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MyTextFormField extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  const _MyTextFormField(
      {required this.icon,
      required this.text,
      required this.controller,
      required this.validator,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(6.0))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10.0),
                Text(
                  text,
                  style: const TextStyle(color: Colors.black54),
                )
              ],
            ),
          ),
          const Divider(color: Colors.black, thickness: 1.5, height: 0.0),
          //TODO FOMR
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              keyboardType: keyboardType,
              obscureText: keyboardType == TextInputType.text,
              cursorColor: Colors.black,
              style: const TextStyle(fontWeight: FontWeight.bold),
              validator: (value) => validator(value))
        ],
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  const SocialIcon({
    super.key,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.black),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 36),
      ),
    );
  }

  // Color getColor(IconData icon) {
  //   if (icon == Ionicons.logo_google) {
  //     return Colors.red;
  //   } else if (icon == Ionicons.logo_facebook) {
  //     return Colors.blue;
  //   } else {
  //     return Colors.grey;
  //   }
  // }
}
