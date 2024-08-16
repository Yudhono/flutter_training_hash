import 'package:dio/dio.dart';
import 'package:new_shop/api_service.dart';
import 'package:new_shop/home/response/profile_failed_response.dart';
import 'package:new_shop/home/response/profile_success_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDatasource {
  Future<(ProfileFailedResponse?, ProfileSuccesResponse?)> profile() async {
    try {
      // Retrieve the token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      if (token == null) {
        return (ProfileFailedResponse(message: 'Token not found'), null);
      }

      // Add the token to the request headers
      final response = await APIService.instance.request(
        '/api/v1/auth/profile/',
        DioMethod.get,
        contentType: 'application/json',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      return (
        null,
        ProfileSuccesResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      return (
        ProfileFailedResponse.fromJson(e.response?.data),
        null,
      );
    }
  }
}
