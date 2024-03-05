
import 'dart:io';
import 'dart:convert';
import 'BaseApiServices.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider_mvvm/data/app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);

    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await post(Uri.parse(url),
      body: data
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
      print('responseJson $responseJson');
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response httpResponse) {
    switch (httpResponse.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(httpResponse.body);
        return responseJson;
      case 400:
        throw BadRequestException(httpResponse.body.toString());
      case 404:
        throw UnAuthorisedException(httpResponse.body.toString());
      case 500:
        throw BadRequestException(httpResponse.body.toString());
      default:
        throw FetchDataException(
            'Error occured while communicating with server' +
                'with status code' +
                httpResponse.statusCode.toString());
    }
  }
}
