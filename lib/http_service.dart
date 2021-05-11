import 'package:dio/dio.dart';

class HttpService {
  Dio _dio = Dio();

  HttpService() {
    _dio = Dio(
      BaseOptions(
        headers: {
          'x-hasura-admin-secret':
              'ZOxAZQ16Arbubv2mVI4lx2XIGCFJE3kACn9nsI3XSlO1veibydW7OJ8g6OiP270U'
        },
        baseUrl: 'https://verified-mammal-79.hasura.app/api/rest/',
        connectTimeout: 5000,
        receiveTimeout: 5000,
      ),
    );
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;

    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      print("Error occured during get request : ${e.message}");
      throw Exception(e.message);
    }

    return response;
  }
}
