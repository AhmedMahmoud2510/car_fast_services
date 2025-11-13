import 'package:quick_cars_service/barrel.dart';

class DioFactory {
  static Dio dio = Dio();

  static Future<void> init() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      validateStatus: (status) => true,
    );

    dio = Dio(baseOptions);
    addDioInterceptor();
    return Future.value();
  }

  Future<Response?> get({required String endPoint, data}) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization':
          "Bearer ${await CacheHelper.getData(key: CacheKeys.userToken) ?? ""}",
    };
    return await dio.get(endPoint, queryParameters: data);
  }

  Future<Response?> post({required String endPoint, data}) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization':
          "Bearer ${await CacheHelper.getData(key: CacheKeys.userToken) ?? ""}",
    };
    return await dio.post(endPoint, data: data);
  }

  Future<Response?> postWithImage({
    required String endPoint,
    required Map<String, dynamic> data,
    File? imageFile,
  }) async {
    try {
      dio.options.headers = {
        'Accept': 'application/json',
        'Authorization':
            "Bearer ${await CacheHelper.getData(key: CacheKeys.userToken) ?? ""}",
      };
      FormData formData = FormData.fromMap({
        ...data,
        if (imageFile != null)
          'image': await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
      });

      // Post the data
      final response = await dio.post(endPoint, data: formData);
      return response;
    } catch (e) {
      debugPrint('POST ERROR: $e');
      return null;
    }
  }

  static void addDioInterceptor() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
