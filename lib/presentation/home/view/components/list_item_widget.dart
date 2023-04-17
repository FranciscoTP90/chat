import 'package:chat_app/domain/models/user.dart';
import 'package:chat_app/presentation/chat/bloc/chat_bloc.dart';
import 'package:chat_app/presentation/chat/view/chat_screen.dart';
import 'package:chat_app/presentation/widgets/circle_img_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      this.date,
      this.counter,
      this.isOnline,
      required this.user,
      required this.token});

  final String title;
  final String subtitle;
  final DateTime? date;
  final int? counter;
  final bool? isOnline;
  final Usuario user;
  final String token;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const String url =
        "https://pbs.twimg.com/media/FqqEkkZWcAARvYc?format=jpg&name=large";

    return GestureDetector(
      onTap: () {
        context.read<ChatBloc>().add(ChatEvent.onSelectUser(user));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatScreen(),
            ));
      },
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        margin: const EdgeInsets.only(bottom: 15.0),
        height: 100,
        child: Stack(
          children: [
            Positioned(
              bottom: 2.0,
              left: 0.0,
              child: Container(
                height: 85,
                width: size.width - 20,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    border: Border.all(width: 1.5, color: Colors.black),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(24.0))),
              ),
            ),
            Positioned(
              top: 0,
              left: 6,
              right: 6,
              child: Container(
                  height: 90,
                  width: size.width - 32,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.5, color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(22.0))),
                  child: Row(
                    children: [
                      const SizedBox(width: 10.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleImgProfile(url: user.imgProfile ?? ''),
                        ],
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0),
                            Text(
                              title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(right: 12.0, top: 5.0),
                              child: Text(
                                subtitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 10.0),
                          if (date != null)
                            // final time = DateFormat('hh:mm a').format(date?.toLocal());
                            ...[
                            Text(DateFormat('hh:mm a').format(date!.toLocal())),
                            Text(
                              user.online ? 'Online' : 'Offline',
                              // maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color:
                                      user.online ? Colors.green : Colors.red),
                            ),
                          ]
                          // if (counter != null)
                          // Container(
                          //   width: 20,
                          //   height: 20,
                          //   alignment: Alignment.center,
                          //   decoration: BoxDecoration(
                          //       color: Colors.green,
                          //       border: Border.all(
                          //           width: 1.5, color: Colors.black),
                          //       shape: BoxShape.circle),
                          //   child: Text(
                          //     "$counter",
                          //     style: const TextStyle(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(width: 10.0)
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
