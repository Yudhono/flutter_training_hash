import 'package:equatable/equatable.dart';

sealed class CreateProductBlocEvent extends Equatable {
  const CreateProductBlocEvent();

  @override
  List<Object> get props => [];
}

final class CreateProductRequest extends CreateProductBlocEvent {
  final Map<String, dynamic> productData;

  const CreateProductRequest(this.productData);

  @override
  List<Object> get props => [productData];
}
