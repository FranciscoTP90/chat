part of 'home_bloc.dart';

abstract class HomeEvent {
  factory HomeEvent.onGetUsers(String myUID) => _GetUsers(myUID);
  factory HomeEvent.onChangePage(int page) => _ChangePage(page);
}

class _GetUsers implements HomeEvent {
  _GetUsers(this.myUID);
  final String myUID;
}

class _ChangePage implements HomeEvent {
  _ChangePage(this.page);
  final int page;
}
