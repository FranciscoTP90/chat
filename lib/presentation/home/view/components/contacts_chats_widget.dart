import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';

enum Selected { chat, contacts }

class ContactChatWidget extends StatefulWidget {
  const ContactChatWidget({super.key});

  @override
  State<ContactChatWidget> createState() => _ContactChatWidgetState();
}

class _ContactChatWidgetState extends State<ContactChatWidget> {
  // Selected _selected = Selected.chat;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          height: 60,
          width: size.width,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              border: Border.all(width: 1.5, color: Colors.black),
              borderRadius: BorderRadius.circular(100)),
          child: Row(children: [
            _Item(
              isSelected: state.page == 0,
              text: "Chats",
              onTap: () {
                // setState(() {
                //   _selected = Selected.chat;
                // });
                context.read<HomeBloc>().add(HomeEvent.onChangePage(0));
              },
            ),
            const SizedBox(width: 10.0),
            _Item(
              isSelected: state.page == 1,
              text: "Contacts",
              onTap: () {
                context.read<HomeBloc>().add(HomeEvent.onChangePage(1));
                // setState(() {
                //   _selected = Selected.contacts;
                // });
              },
            ),
          ]),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  final bool isSelected;
  final Function()? onTap;
  final String text;

  const _Item({required this.isSelected, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Container(
        height: 45,
        width: size.width * 0.41,
        alignment: Alignment.center,
        decoration: !isSelected
            ? null
            : BoxDecoration(
                color: Colors.green,
                border: Border.all(width: 1.5, color: Colors.black),
                borderRadius: BorderRadius.circular(100)),
        child: Text(
          text,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : null),
        ),
      ),
    );
  }
}
