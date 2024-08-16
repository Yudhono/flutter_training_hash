import 'package:dio/dio.dart';
import 'package:new_shop/addproduct/response/add_product_failed_response.dart';
import 'package:new_shop/addproduct/response/add_product_success_response.dart';

import 'package:new_shop/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddproductDatasource {
  Future<(AddProductFailedResponse?, AddProductSuccessResponse?)> createProduct(
      Map<String, dynamic> productData) async {
    try {
      // Retrieve the token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      if (token == null) {
        return (AddProductFailedResponse(message: ['token not found']), null);
      }

      print('productData data source: ${productData}');

      // Add the token to the request headers and send the POST request
      final response = await APIService.instance.request(
        '/api/v1/products/',
        DioMethod.post, // Use the post method for POST requests
        contentType: 'application/json',
        param: productData,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('create product response: ${response}');

      return (
        null,
        AddProductSuccessResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      return (
        AddProductFailedResponse.fromJson(e.response?.data),
        null,
      );
    }
  }
}
