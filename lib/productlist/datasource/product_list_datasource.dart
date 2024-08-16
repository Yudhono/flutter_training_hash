import 'package:dio/dio.dart';
import 'package:new_shop/api_service.dart';
import 'package:new_shop/productlist/response/product_list_failed_response.dart';
import 'package:new_shop/productlist/response/product_list_succes_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDatasource {
  Future<(ProductListFailedResponse?, List<ProductResponse>?)> fetchProducts(
      {int offset = 0, int limit = 10}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      if (token == null) {
        return (ProductListFailedResponse(message: 'Token not found'), null);
      }

      final response = await APIService.instance.request(
        '/api/v1/products/?offset=$offset&limit=$limit',
        DioMethod.get,
        contentType: 'application/json',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Convert the dynamic list to List<ProductResponse>
      final List<dynamic> data =
          response.data; // Assuming response.data is List<dynamic>
      final List<ProductResponse> products =
          data.map((x) => ProductResponse.fromJson(x)).toList();

      return (null, products);
    } on DioException catch (e) {
      return (
        ProductListFailedResponse.fromJson(e.response?.data),
        null,
      );
    }
  }

  createProduct(Map<String, dynamic> productData) {}
}
