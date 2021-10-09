import 'package:dio/dio.dart';

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Dio dio = Dio();

  Future<Response> get(String url, {Map headers}) async {
    var response;
    try {
      dio.options.baseUrl = "https://cosmo.fahita.store/api/";
      response = await dio.get(url,
          options: Options(
            headers: headers,
            responseType: ResponseType.plain,
          ));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
        print("response from get : " + e.response.toString());
      } else {
        print("throw an exception response get: " + e.toString());
        throw e;
      }
    }
    return handleResponse(response);
  }

  Future<Response> post(String url,
      {Map headers, FormData body, encoding}) async {
    var response;
    dio.options.baseUrl = "https://cosmo.fahita.store/api/";
    try {
      response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          requestEncoder: encoding,
          responseType: ResponseType.plain,
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
        print("response from post : " + e.response.toString());
      } else {
        print("throw an exception response post: " + e.toString());
        throw e;
      }
    }
    return handleResponse(response);
  }

  Future<Response> delete(String url, {Map headers}) {
    return dio
        .delete(
      url,
      options: Options(headers: headers),
    )
        .then((Response response) {
      return handleResponse(response);
    });
  }

  Future<Response> put(String url, {Map headers, body, encoding}) {
    return dio
        .put(url,
            data: body,
            options: Options(headers: headers, requestEncoder: encoding))
        .then((Response response) {
      return handleResponse(response);
    });
  }

  Response handleResponse(Response response) {
    print("response from handle: " + response.toString());
    if (response != null) {
      final int statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 300) {
        return response;
      } else {
        return response;
      }
    } else {
      return null;
    }
  }
}
