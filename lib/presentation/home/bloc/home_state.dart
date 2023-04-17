// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  const HomeState(
      {required this.users,
      required this.homeStatus,
      required this.page,
      required this.chatsRooms});
  final List<Usuario> users;
  final List<ChatsRoom> chatsRooms;
  final HomeStatus homeStatus;
  final int page;

  factory HomeState.initialState() => const HomeState(
      users: [], homeStatus: HomeStatus.initial, page: 0, chatsRooms: []);

  @override
  List<Object> get props => [users, homeStatus, page];

  HomeState copyWith(
      {List<Usuario>? users,
      HomeStatus? homeStatus,
      int? page,
      List<ChatsRoom>? chatsRooms}) {
    return HomeState(
        users: users ?? this.users,
        homeStatus: homeStatus ?? this.homeStatus,
        page: page ?? this.page,
        chatsRooms: chatsRooms ?? this.chatsRooms);
  }
}
