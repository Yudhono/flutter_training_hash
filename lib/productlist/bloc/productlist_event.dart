part of 'productlist_bloc.dart';

sealed class ProductlistEvent extends Equatable {
  const ProductlistEvent();

  @override
  List<Object> get props => [];
}

final class FetchProductsEvent extends ProductlistEvent {}
