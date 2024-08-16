import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_shop/productlist/datasource/product_list_datasource.dart';
import 'package:new_shop/productlist/response/product_list_succes_response.dart';

part 'productlist_event.dart';
part 'productlist_state.dart';

class ProductlistBloc extends Bloc<ProductlistEvent, ProductlistState> {
  final ProductDatasource _productDatasource;
  int _offset = 0;
  final int _limit = 10;
  bool _isFetching = false;
  bool _hasMoreProducts = true;

  ProductlistBloc(this._productDatasource) : super(ProductlistInitial()) {
    on<FetchProductsEvent>((event, emit) async {
      if (_isFetching || !_hasMoreProducts) return;
      _isFetching = true;

      emit(state is ProductlistInitial || _offset == 0
          ? ProductlistLoading()
          : ProductlistLoadMoreLoading(
              products: state is ProductlistLoadSuccess
                  ? (state as ProductlistLoadSuccess).products
                  : []));

      final (failure, products) = await _productDatasource.fetchProducts(
        offset: _offset,
        limit: _limit,
      );

      if (failure != null) {
        emit(ProductlistLoadFailure(
            message: failure.message ?? 'Unknown error'));
      } else if (products != null && products.isNotEmpty) {
        _offset += _limit;
        _hasMoreProducts = products.length == _limit;

        // Combine old products with new products
        final List<ProductResponse> currentProducts =
            state is ProductlistLoadSuccess
                ? (state as ProductlistLoadSuccess).products
                : [];

        final List<ProductResponse> allProducts =
            List<ProductResponse>.from(currentProducts)..addAll(products);

        emit(ProductlistLoadSuccess(products: allProducts));
      } else {
        _hasMoreProducts = false;
        // If no more products, emit current products state
        emit(ProductlistLoadSuccess(
            products: state is ProductlistLoadSuccess
                ? (state as ProductlistLoadSuccess).products
                : []));
      }

      _isFetching = false;
    });
  }

  void fetchNextPage() {
    add(FetchProductsEvent());
  }

  void resetPagination() {
    _offset = 0;
    _hasMoreProducts = true;
    add(FetchProductsEvent());
  }
}
