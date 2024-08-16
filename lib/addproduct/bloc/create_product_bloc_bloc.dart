import 'package:bloc/bloc.dart';
import 'package:new_shop/addproduct/bloc/create_product_bloc_event.dart';
import 'package:new_shop/addproduct/bloc/create_product_bloc_state.dart';
import 'package:new_shop/addproduct/datasource/addproduct_datasource.dart';

class CreateProductBloc
    extends Bloc<CreateProductBlocEvent, CreateProductBlocState> {
  final AddproductDatasource _productDatasource;

  CreateProductBloc(this._productDatasource)
      : super(CreateProductBlocInitial()) {
    on<CreateProductRequest>(_onCreateProductRequest);
  }

  Future<void> _onCreateProductRequest(
    CreateProductRequest event,
    Emitter<CreateProductBlocState> emit,
  ) async {
    emit(CreateProductLoading());

    final (failure, success) =
        await _productDatasource.createProduct(event.productData);

    if (success != null) {
      emit(const CreateProductSuccess(
          'Product created successfully!')); // Customize message as needed
    } else {
      emit(CreateProductFailure(
        failure?.message?.join(', ') ?? 'An unknown error occurred',
      ));
    }
  }
}
