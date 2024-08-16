import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_shop/home/datasource/profile_datasource.dart';
import 'package:new_shop/home/response/profile_success_response.dart';
import 'package:new_shop/shared/datasource/token_datasource.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TokenDatasource _tokenDatasource;
  final ProfileDatasource _profileDatasource;

  HomeBloc(this._tokenDatasource, this._profileDatasource)
      : super(HomeInitial()) {
    on<UserTapLogoutButton>((event, emit) {
      emit(HomeLoading());
      _tokenDatasource.removeToken();
      emit(HomeLogoutSuccess());
    });

    on<LoadProfile>((event, emit) async {
      emit(HomeLoading());
      final profile = await _profileDatasource.profile();
      if (profile.$2 != null) {
        emit(HomeProfileLoaded(profile.$2!));
      } else {
        emit(HomeError(profile.$1?.message ?? 'Failed to load profile'));
      }
    });
  }
}
