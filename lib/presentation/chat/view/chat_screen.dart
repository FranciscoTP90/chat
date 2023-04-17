import 'dart:developer';

import 'package:chat_app/core/blocs/socket/socket_bloc.dart';
import 'package:chat_app/domain/models/mensajes_response.dart';
import 'package:chat_app/presentation/chat/bloc/chat_bloc.dart';
import 'package:chat_app/presentation/login/bloc/login_bloc.dart';
import 'package:chat_app/presentation/widgets/circle_img_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import 'components/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    // context.read<ChatBloc>().initStream();
    Future.microtask(() {
      getChat();
    });

    // context.read<SocketBloc>().getSocket!.on(
    //       'mensaje-personal',
    //       _escucharMensaje,
    //     );
  }

  // void _escucharMensaje(dynamic payload) {
  //   // if (payload['de'] != _mensajesProvider.usuarioPara!.uid) return;
  //   print("ESCUCHAR MENSAJE");
  //   final message = Mensaje(
  //       id: payload.de,
  //       para: payload.para,
  //       de: payload.de,
  //       mensaje: payload.mensaje,
  //       createdAt: payload.createdAt);

  //   // context.read<ChatBloc>().add(ChatEvent.onAddMessage(message));
  //   context.read<ChatBloc>().streamController.add(message);
  // }

  void getChat() {
    // initializeDateFormatting('de_DE', null).then(formatDates);
    final miUD = context.read<LoginBloc>().state.userModel!.usuario.uid;
    context.read<ChatBloc>().add(ChatEvent.onGetChatMessages(miUD));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = context.read<ChatBloc>().state.userPara!;
    // final miUID = context.read<LoginBloc>().state.userModel!.usuario.uid;
    const String url =
        "https://pbs.twimg.com/media/FqqEkkZWcAARvYc?format=jpg&name=large";
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.black,
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Row(
              children: [
                CircleImgProfile(
                  url: user.imgProfile ?? '',
                  size: 42.0,
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: size.width * 0.2,
                        maxWidth: size.width * 0.33,
                        minHeight: 10,
                        maxHeight: 20,
                      ),
                      child: Text(
                        user.name!.isEmpty ? user.email : user.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Text(
                      user.online ? "Online" : "Offline",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: user.online ? Colors.green : Colors.red),
                    )
                  ],
                )
              ],
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Ionicons.arrow_back_circle_outline)),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Ionicons.call_outline)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.videocam_outline)),
            ]),
        body: BlocBuilder<ChatBloc, ChatState>(
          // buildWhen: (previous, current) {
          //   return (previous.historyStatus != current.historyStatus) ||
          //       (previous.mensajes.length != current.mensajes.length);
          // },
          builder: (context, state) {
            if (state.historyStatus == HistoryStatus.loading ||
                state.historyStatus == HistoryStatus.initial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.historyStatus == HistoryStatus.error) {
              return const Center(
                child: Text("Error"),
              );
            }

            return ChatHistory(mensajes: state.mensajes);
          },
        ));
  }
}

class ChatHistory extends StatefulWidget {
  final List<Mensaje> mensajes;
  const ChatHistory({super.key, required this.mensajes});

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _cargarHistorial();
  }

  void _cargarHistorial() {
    final history = widget.mensajes.map((m) => ChatMessage(
        message: m,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward()));
    if (mounted) {
      context.read<ChatBloc>().add(ChatEvent.onSetMessagesWidgets(history));
    }
  }

  @override
  Widget build(BuildContext context) {
    final mensajesWidgets = context.watch<ChatBloc>().state.messagesWidgets;
    return Container(
      child: Column(
        children: [
          Flexible(
              child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: mensajesWidgets.length,
            reverse: true,
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (BuildContext context, int index) {
              return mensajesWidgets[index];
            },
          )),
          const _InputWidget()
        ],
      ),
    );
  }
}

class _InputWidget extends StatefulWidget {
  const _InputWidget();

  @override
  State<_InputWidget> createState() => __InputWidgetState();
}

class __InputWidgetState extends State<_InputWidget>
    with TickerProviderStateMixin {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  void _escucharMensaje(dynamic payload) {
    // if (payload['de'] != _mensajesProvider.usuarioPara!.uid) return;
    print("ESCUCHAR MENSAJE");
    final message = Mensaje(
        id: payload["de"],
        para: payload["para"],
        de: payload["de"],
        mensaje: payload["mensaje"],
        createdAt: payload["createdAt"]);

    ChatMessage messageWidget = ChatMessage(
        message: message,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 300)));

    context.read<ChatBloc>().add(ChatEvent.onSetMessageWidget(messageWidget));
    messageWidget.animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          border: Border.all(width: 1.5, color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(12.0))),
      child: Row(
        children: [
          Flexible(
              child: Scrollbar(
                  child: TextFormField(
                      maxLines: null,
                      controller: _textEditingController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        filled: false,
                        hintText: 'Type something',
                        prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Ionicons.happy_outline,
                              color: Colors.black54,
                            )),

                        // helperText: 'Type something',
                      )))),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.camera_outline,
              color: Colors.black54,
            ),
          ),
          // const SizedBox(width: 10.0),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.attach_outline,
              color: Colors.black54,
            ),
          ),
          IconButton(
            onPressed: () {
              log("TEXTO: ${_textEditingController.text}");
              if (_textEditingController.text.isEmpty) {
                return;
              }
              final String de =
                  context.read<LoginBloc>().state.userModel!.usuario.uid;
              final String para = context.read<ChatBloc>().state.userPara!.uid;

              final messageWidget = ChatMessage(
                  message: Mensaje(
                      id: 'id',
                      para: para,
                      de: de,
                      mensaje: _textEditingController.text,
                      createdAt: DateTime.now()),
                  animationController: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 400)));
              messageWidget.animationController?.forward();

              context
                  .read<ChatBloc>()
                  .add(ChatEvent.onSetMessageWidget(messageWidget));

              log(" de: $de - para: $para -mensaje: ${_textEditingController.text}");
              context.read<SocketBloc>().getEmit('mensaje-personal', {
                'de': de,
                'para': para,
                'mensaje': _textEditingController.text
              });
              _textEditingController.clear();
              //Quitat teclado
              // FocusScope.of(context).unfocus();
            },
            icon: const Icon(
              Ionicons.send,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

// class _MyTextFormField extends StatefulWidget {
//   const _MyTextFormField({
//     required this.size,
//   });

//   final Size size;

//   @override
//   State<_MyTextFormField> createState() => _MyTextFormFieldState();
// }

// class _MyTextFormFieldState extends State<_MyTextFormField> {
//   late TextEditingController _textEditingController;

//   @override
//   void initState() {
//     _textEditingController = TextEditingController();
//     super.initState();
//     context.read<SocketBloc>().getSocket!.on(
//           'mensaje-personal',
//           _escucharMensaje,
//         );
//   }

//   void _escucharMensaje(dynamic payload) {
//     // if (payload['de'] != _mensajesProvider.usuarioPara!.uid) return;
//     print("ESCUCHAR MENSAJE");
//     final message = Mensaje(
//         id: payload.de,
//         para: payload.para,
//         de: payload.de,
//         mensaje: payload.mensaje,
//         createdAt: payload.createdAt);

//     context.read<ChatBloc>().add(ChatEvent.onAddMessage(message));
//     // context.read<ChatBloc>().streamController.add(message);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       width: widget.size.width,
//       margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
//       decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.2),
//           border: Border.all(width: 1.5, color: Colors.black),
//           borderRadius: const BorderRadius.all(Radius.circular(12.0))),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextFormField(
//               controller: _textEditingController,
//               maxLines: 3,
//               cursorColor: Colors.black,
//               decoration: InputDecoration(
//                 filled: false,
//                 hintText: 'Type something',
//                 prefixIcon: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Ionicons.happy_outline,
//                       color: Colors.black54,
//                     )),

//                 // helperText: 'Type something',
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Ionicons.camera_outline,
//               color: Colors.black54,
//             ),
//           ),
//           // const SizedBox(width: 10.0),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Ionicons.attach_outline,
//               color: Colors.black54,
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               log("TEXTO: ${_textEditingController.text}");
//               if (_textEditingController.text.isEmpty) {
//                 return;
//               }
//               final String de =
//                   context.read<LoginBloc>().state.userModel!.usuario.uid;
//               final String para = context.read<ChatBloc>().state.userPara!.uid;
//               log(" de: $de - para: $para -mensaje: ${_textEditingController.text}");
//               context.read<SocketBloc>().getEmit('mensaje-personal', {
//                 'de': de,
//                 'para': para,
//                 'mensaje': _textEditingController.text
//               });
//             },
//             icon: const Icon(
//               Ionicons.send,
//               color: Colors.black54,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// }
