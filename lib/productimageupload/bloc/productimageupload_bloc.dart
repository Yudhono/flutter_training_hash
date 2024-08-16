import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_shop/addproduct/response/add_product_failed_response.dart';
import 'package:new_shop/productimageupload/datasource/productimageupload_datasource.dart';
import 'package:new_shop/productimageupload/response/upload_product_image_success_response.dart';

part 'productimageupload_event.dart';
part 'productimageupload_state.dart';

class ProductImageUploadBloc
    extends Bloc<ProductImageUploadEvent, ProductImageUploadState> {
  final UploadImageDatasource uploadImageDatasource;

  ProductImageUploadBloc(this.uploadImageDatasource)
      : super(ProductImageUploadInitial()) {
    on<ProductImageUploadRequested>((event, emit) async {
      emit(ProductImageUploadLoading());

      // Add source type to distinguish between camera and gallery
      final (failure, success) =
          await uploadImageDatasource.uploadImage(event.imageFile);

      if (failure != null) {
        if (failure != null) {
          emit(ProductImageUploadFailure(failure.message ?? []));
        }
      } else if (success != null) {
        emit(ProductImageUploadSuccess(success.location, event.source));
      }
    });
  }
}
