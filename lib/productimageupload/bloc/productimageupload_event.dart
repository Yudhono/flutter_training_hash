part of 'productimageupload_bloc.dart';

abstract class ProductImageUploadEvent extends Equatable {
  const ProductImageUploadEvent();

  @override
  List<Object> get props => [];
}

class ProductImageUploadRequested extends ProductImageUploadEvent {
  final File imageFile;
  final ImageSource source; // Add a parameter to distinguish the source

  const ProductImageUploadRequested(this.imageFile, this.source);

  @override
  List<Object> get props => [imageFile, source];
}
