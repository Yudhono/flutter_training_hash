import 'package:equatable/equatable.dart';

sealed class CreateProductBlocState extends Equatable {
  const CreateProductBlocState();

  @override
  List<Object> get props => [];
}

final class CreateProductBlocInitial extends CreateProductBlocState {}

final class CreateProductLoading extends CreateProductBlocState {}

final class CreateProductSuccess extends CreateProductBlocState {
  final String message; // Adjust as needed

  const CreateProductSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class CreateProductFailure extends CreateProductBlocState {
  final String error;

  const CreateProductFailure(this.error);

  @override
  List<Object> get props => [error];
}
