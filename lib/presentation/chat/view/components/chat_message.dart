import 'package:chat_app/domain/models/mensajes_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/chat_bloc.dart';

class ChatMessage extends StatelessWidget {
  final Mensaje message;
  final AnimationController? animationController;
  const ChatMessage(
      {super.key, required this.message, this.animationController});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final toUID = context.read<ChatBloc>().state.userPara!.uid;
    final bool notMyMsg = message.para != toUID;
    // final a = message.createdAt.toLocal();

    final time = DateFormat('hh:mm a').format(message.createdAt.toLocal());

    return FadeTransition(
      opacity: animationController!,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController!, curve: Curves.easeOut),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: notMyMsg
              ? Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(time, style: const TextStyle(color: Colors.grey)),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        constraints: BoxConstraints(
                            minHeight: 30,
                            maxHeight: size.height,
                            minWidth: 100,
                            maxWidth: size.width * 0.7),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            border: Border.all(width: 1.5, color: Colors.black),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              // topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            )),
                        child: Text(
                          message.mensaje,
                          style: const TextStyle(height: 2),
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(time, style: const TextStyle(color: Colors.grey)),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        constraints: BoxConstraints(
                            minHeight: 30,
                            maxHeight: size.height,
                            minWidth: 100,
                            maxWidth: 250),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(width: 1.5, color: Colors.black),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            )),
                        child: Text(
                          message.mensaje,
                          style:
                              const TextStyle(color: Colors.white, height: 2),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
