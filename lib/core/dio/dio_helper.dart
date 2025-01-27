import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mycompass_admin_website/core/api_constants.dart';
import 'package:mycompass_admin_website/core/local_storage/cach_keys.dart';
import 'package:mycompass_admin_website/core/local_storage/cache_helper.dart';
import 'package:mycompass_admin_website/core/log_util.dart';
import 'package:mycompass_admin_website/managers/admin_cubit.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl, // Set your base URL here
      connectTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds
    );
  }

  Future<Response> getData({required String endPoint}) async {
    Response response = await dio.get(
      ApiConstants.baseUrl + endPoint,
      options: Options(
        headers: {
          "authorization": "${CacheHelper.getString(key: CacheKeys.token)}",
        },
      ),
    );
    return response;
  }

  Future<Response> getData2({
    required String endPoint,
    Map<String, dynamic>? query, // Define the optional query parameter
  }) async {
    Response response = await dio.get(
      ApiConstants.baseUrl + endPoint,
      queryParameters: query, // Pass the query parameter here
      options: Options(
        headers: {
          "authorization": "${CacheHelper.getString(key: CacheKeys.token)}",
        },
      ),
    );
    return response;
  }

  Future<Response> postData({
    bool handleError = true,
    required String endPoint,
    Object? body,
    String? token,
  }) async {
    try {
      Response response = await dio.post(
        ApiConstants.baseUrl + endPoint,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            "authorization": "${CacheHelper.getString(key: CacheKeys.token)}",
            // 'Content-Type': 'multipart/form-data'
          },
        ),
      );
      if (response.statusCode == 204 ||
          response.statusCode == 200 ||
          response.statusCode == 201) {
      } else if (response.statusCode == 403) {}
      return response;
    } on DioError {
      rethrow;
    }
  }

  // Future<Response> postFormData({
  //   bool handleError = true,
  //   required String endPoint,
  //   FormData? formData,
  //   String? token,
  // }) async {
  //   try {
  //     Response response = await dio.post(
  //       ApiConstants.baseUrl + endPoint,
  //       data: formData,
  //       options: Options(
  //         followRedirects: false,
  //         validateStatus: (status) => true,
  //         headers: {
  //           "authorization":
  //           "${CacheHelper.getString(key: CacheKeys.token)}",
  //         },
  //       ),
  //     );
  //     if (response.statusCode == 204 ||
  //         response.statusCode == 200 ||
  //         response.statusCode == 201) {
  //     } else if (response.statusCode == 403) {}
  //     return response;
  //   } on DioError {
  //     rethrow;
  //   }
  // }
  Future<Response> postFormData({
    bool handleError = true,
    required String endPoint,
    FormData? formData,
    String? token,
  }) async {
    try {
      Response response = await dio.post(
        ApiConstants.baseUrl + endPoint,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: token != null ? {"authorization": "$token"} : {},
        ),
      );

      // Log the response details
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 204 ||
          response.statusCode == 200 ||
          response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 403) {
        print('Authorization error');
        return response;
      } else {
        print('Error: ${response.data}');
        return response;
      }
    } on DioError catch (e) {
      print('Dio error: $e');
      rethrow;
    }
  }

  Future<Response> postDataWithoutAuth({
    bool handleError = true,
    required String endPoint,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {
      Response response = await dio.post(
        ApiConstants.baseUrl + endPoint,
        data: body,
      );
      log(response.data);
      if (response.statusCode == 204 ||
          response.statusCode == 200 ||
          response.statusCode == 201) {
      } else if (response.statusCode == 403) {
        log(response.data);
      }
      return response;
    } on DioError {
      rethrow;
    }
  }

  Future<Response> putData({
    required String endPoint,
    Map<String, dynamic>? body,
  }) async {
    return await dio.put('${ApiConstants.baseUrl}$endPoint',
        data: body,
        options: Options(
          headers: {
            "authorization": "${CacheHelper.getString(key: CacheKeys.token)}",
          },
        ));
  }

  Future<Response> putDataInFormData({
    required String endPoint,
    dynamic body, // Changed to dynamic to accept both Map and FormData
  }) async {
    return await dio.put(
      '${ApiConstants.baseUrl}$endPoint',
      data: body,
      options: Options(
        headers: {
          "authorization": "${CacheHelper.getString(key: CacheKeys.token)}",
        },
      ),
    );
  }

  Future<Response> postDataInFormData({
    required String endPoint,
    dynamic body, // Changed to dynamic to accept both Map and FormData
  }) async {
    return await dio.post(
      '${ApiConstants.baseUrl}$endPoint',
      data: body,
      options: Options(
        headers: {
          "authorization": "${CacheHelper.getString(key: CacheKeys.token)}",
        },
      ),
    );
  }

  Future<Response> patchData({
    required String endPoint,
    Object? body,
  }) async {
    return await dio.patch('${ApiConstants.baseUrl}$endPoint',
        data: body,
        options: Options(headers: {
          "authorization": "${CacheHelper.getString(key: CacheKeys.token)}",
        }));
  }

  Future<Response> deleteFromCart({
    required String endPoint,
    Map<String, dynamic>? body,
  }) async {
    return await dio.put('${ApiConstants.baseUrl}$endPoint',
        data: body,
        options: Options(
          headers: {
            "authorization": "${CacheHelper.getString(key: CacheKeys.token)}",
          },
        ));
  }

  Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? body,
  }) async {
    return await dio.delete(ApiConstants.baseUrl + endPoint,
        data: body,
        options: Options(headers: {
          "authorization": "${CacheHelper.getString(key: CacheKeys.token)}",
        }));
  }

  /// Download Media
  static Future<Response> downloadMedia({
    required String url,
    required String path,
    Map<String, dynamic>? query,
    Function(int, int)? onReceiveProgress,
    String? token,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = '$token';
    } else {
      dio.options.headers['Authorization'] =
          '${CacheHelper.getString(key: CacheKeys.token)}';
    }
    return await dio.download(
      url,
      path,
      queryParameters: query,
      onReceiveProgress: onReceiveProgress,
    );
  }

// static void logout(BuildContext context) async {
//   await CacheHelper.clearShared();
//   / TOD/O: Implement Screen To Logout
// context.pushReplacementNamed('');
// Navigator.pushReplacementNamed(context, 'checkScreen');
// }
}
