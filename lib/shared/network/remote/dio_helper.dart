import 'package:dio/dio.dart';

class DioHelper
{

  static late Dio dio;

  static init()
  {

    dio = Dio(
      BaseOptions(
        baseUrl:'',
        receiveDataWhenStatusError:true,
      ),
    );
  }


  static Future<Response> getData({
    required String url,
    required Map<String,dynamic> query,
  })async
  {
    return await dio.get(
        url,
        queryParameters: query
    );
  }



  static Future<Response> postData(
      {
        required String url,
        required Map<String,String> data,
      }
      ) async
  {

    return dio.post(
      url,
      data: data,
      options: Options(
        followRedirects: false,
        validateStatus: (status) => true
      )
    );
  }

  static Future<Response> putData(
      {
        required String url,
        Map<String,String>? query,
        required Map<String,String> data,
        String lang = 'en',
        String token='',
      }
      ) async
  {

    dio.options.headers =  {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };


    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }



}