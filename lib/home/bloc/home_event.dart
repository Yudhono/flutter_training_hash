part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class UserTapLogoutButton extends HomeEvent {}

final class LoadProfile extends HomeEvent {}
