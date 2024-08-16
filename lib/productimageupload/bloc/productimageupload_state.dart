part of 'productimageupload_bloc.dart';

abstract class ProductImageUploadState extends Equatable {
  const ProductImageUploadState();

  @override
  List<Object> get props => [];
}

class ProductImageUploadInitial extends ProductImageUploadState {}

class ProductImageUploadLoading extends ProductImageUploadState {}

class ProductImageUploadSuccess extends ProductImageUploadState {
  final String location;
  final ImageSource source; // Add a parameter to indicate the source

  const ProductImageUploadSuccess(this.location, this.source);

  @override
  List<Object> get props => [location, source];
}

class ProductImageUploadFailure extends ProductImageUploadState {
  final List<String> messages;

  const ProductImageUploadFailure(this.messages);

  @override
  List<Object> get props => [messages];
}
