import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:url_shortener_app/core/api/custom_exceptions.dart';

import 'api_responses.dart';

class HttpRequests {
  Future<dynamic> post({
    required http.Client httpClient,
    required String url,
    dynamic body,
    String? token,
  }) async {
    late dynamic response;
    try {
      final request = await httpClient.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      response = ApiResponses.apiResponses(request);
    } on NotFoundException {
      throw FetchDataException('Endpoint not exists');
    }
    return response;
  }

  Future<dynamic> get({
    required http.Client httpClient,
    required String url,
    String? token,
    String? param,
  }) async {
    late dynamic response;
    try {
      final request = await httpClient.get(
        Uri.parse(param != null ? '$url/$param' : url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      response = ApiResponses.apiResponses(request);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on NotFoundException {
      throw FetchDataException('Endpoint not exists');
    }
    return response;
  }

  Future<dynamic> put({
    required http.Client httpClient,
    required String url,
    dynamic body,
    String? token,
  }) async {
    late dynamic response;
    try {
      final request = await httpClient.put(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": 'Bearer $token',
        },
      );
      response = ApiResponses.apiResponses(request);
    } on NotFoundException {
      throw FetchDataException('Endpoint not exists');
    }
    return response;
  }
}
