part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLogoutSuccess extends HomeState {}

final class HomeProfileLoaded extends HomeState {
  final ProfileSuccesResponse profile;

  const HomeProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
