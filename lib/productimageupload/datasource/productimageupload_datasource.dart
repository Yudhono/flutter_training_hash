import 'dart:io';
import 'package:dio/dio.dart';
import 'package:new_shop/addproduct/response/add_product_failed_response.dart';
import 'package:new_shop/productimageupload/response/upload_product_image_success_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_shop/api_service.dart';

class UploadImageDatasource {
  Future<(AddProductFailedResponse?, FileResponseSuccess?)> uploadImage(
      File imageFile) async {
    try {
      // Retrieve the token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      if (token == null) {
        return (AddProductFailedResponse(message: ['token not found']), null);
      }

      // Prepare the file data to be uploaded
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'file':
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });

      // Add the token to the request headers and send the POST request
      final response = await APIService.instance.request(
        '/api/v1/files/upload',
        DioMethod.post,
        contentType: 'multipart/form-data',
        data: formData, // Pass the FormData object here
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('upload image response: ${response}');

      // Assuming the response contains the image URL or an identifier
      return (
        null,
        FileResponseSuccess(
            location: response.data['location'],
            originalname: response.data['originalname'],
            filename: response.data['filename'])
      );
    } on DioException catch (e) {
      return (
        AddProductFailedResponse.fromJson(e.response?.data),
        null,
      );
    }
  }
}
