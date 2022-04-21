import 'dart:convert';
import 'package:http/http.dart' as http;
import 'custom_exceptions.dart';

class ApiResponses {
  static dynamic apiResponses(http.Response response) {
    switch (response.statusCode) {
      case 201:
      case 200:
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        }
        break;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
