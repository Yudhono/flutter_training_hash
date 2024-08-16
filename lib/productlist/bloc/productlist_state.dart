part of 'productlist_bloc.dart';

sealed class ProductlistState extends Equatable {
  const ProductlistState();

  @override
  List<Object> get props => [];
}

final class ProductlistInitial extends ProductlistState {}

final class ProductlistLoading extends ProductlistState {}

final class ProductlistLoadSuccess extends ProductlistState {
  final List<ProductResponse> products;

  const ProductlistLoadSuccess({required this.products});

  @override
  List<Object> get props => [products];
}

final class ProductlistLoadFailure extends ProductlistState {
  final String message;

  const ProductlistLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class ProductlistLoadMoreLoading extends ProductlistState {
  final List<ProductResponse> products;

  const ProductlistLoadMoreLoading({required this.products});

  @override
  List<Object> get props => [products];
}
