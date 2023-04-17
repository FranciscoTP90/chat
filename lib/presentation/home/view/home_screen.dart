import 'package:chat_app/core/routes/routes_app.dart';
import 'package:chat_app/presentation/home/view/components/list_item_widget.dart';
import 'package:chat_app/presentation/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/blocs/socket/socket_bloc.dart';
import '../bloc/home_bloc.dart';
import 'components/contacts_chats_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.token}) : super(key: key);

  final String? token;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int currentPage = 1;
  // final PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<SocketBloc>()
          .add(SocketEvent.onConnectSocket(widget.token!));
      //  context.read<HomeBloc>().add(HomeEvent.onGetUsers(widget.token!));
      final myUID = context.read<LoginBloc>().state.userModel!.usuario.uid;
      context.read<HomeBloc>().add(HomeEvent.onGetUsers(myUID));
      // context.read<SocketBloc>().add(SocketEvent.onConnect());
      // getUserByToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    PageController controller = context.read<HomeBloc>().controller;

    if (context.watch<SocketBloc>().getSocket == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        // leadingWidth: 30,
        titleSpacing: 0,
        leading: const Icon(Ionicons.chatbox_ellipses, color: Colors.orange),
        title: const Text("Chatting Room"),
        actions: [
          BlocBuilder<SocketBloc, SocketState>(
            builder: (context, state) {
              final Color color = state.serverStatus == ServerStatus.Online
                  ? Colors.green
                  : Colors.red;

              return Icon(Ionicons.cloud_circle_outline, color: color);
            },
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                size: 28,
              )),
          IconButton(
              onPressed: () {
                context.read<LoginBloc>().add(LoginEvent.onLogOut());
                Navigator.pushReplacementNamed(context, RoutesApp.login);
              },
              icon: const Icon(
                Icons.logout_outlined,
                size: 28,
              )),
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        // padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const ContactChatWidget(),
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                onPageChanged: (value) {
                  // controller.jumpToPage(value);
                  context.read<HomeBloc>().add(HomeEvent.onChangePage(value));
                },
                children: [
                  _Chats(widget.token!),
                  _Contacts(widget.token!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chats extends StatelessWidget {
  final String token;
  const _Chats(this.token);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.homeStatus == HomeStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.homeStatus == HomeStatus.error) {
          return const Center(child: Text("Error"));
        }
        final chatsRooms = state.chatsRooms;

        return ListView.builder(
          itemCount: chatsRooms.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          itemBuilder: (BuildContext context, int index) {
            return ListItemWidget(
              subtitle: chatsRooms[index].mensaje,
              title: chatsRooms[index].usuario.name!.isEmpty
                  ? chatsRooms[index].usuario.email
                  : chatsRooms[index].usuario.name!,
              counter: index,
              date: chatsRooms[index].createdAt,
              user: chatsRooms[index].usuario,
              token: token,
            );
          },
        );
      },
    );
  }
}

class _Contacts extends StatefulWidget {
  final String token;
  const _Contacts(this.token);

  @override
  State<_Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<_Contacts> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.homeStatus == HomeStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.homeStatus == HomeStatus.error) {
          return const Center(child: Text("Error"));
        }
        final users = state.users;
        return ListView.builder(
          itemCount: users.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          itemBuilder: (BuildContext context, int index) {
            final title = users[index].name!;
            final isOnline = users[index].online;
            return ListItemWidget(
              title: title,
              subtitle: users[index].email,
              isOnline: isOnline,
              user: users[index],
              token: widget.token,
            );
          },
        );
      },
    );
  }
}
