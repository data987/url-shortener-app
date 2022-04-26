import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:url_shortener_app/core/api/api_provider.dart';
import 'package:url_shortener_app/core/api/custom_exceptions.dart';

const Map<String, dynamic> mockResponse = {
  "alias": "51534",
  "_links": {
    "self": "www.facebook.com",
    "short": "https://url-shortener-nu.herokuapp.com/short/51534"
  }
};

const String mock400Response = 'Bad request';

void main() {
  late ApiProvider apiProvider;
  late http.Client client;

  group('Test postUrlToShorten custom responses', () {
    test('Test postUrlToShorten 200 response', () async {
      client = MockClient((request) async {
        return http.Response(json.encode(mockResponse), 200,
            headers: {'content-type': 'application/json'});
      });
      apiProvider = ApiProvider(httpClient: client);

      expect(await apiProvider.postUrlToShorten('mypage.com'), mockResponse);
    });

    test('Test postUrlToShorten 400 response', () async {
      client = MockClient((request) async {
        return http.Response(mock400Response, 400,
            headers: {'content-type': 'application/json'});
      });
      apiProvider = ApiProvider(httpClient: client);

      expect(apiProvider.postUrlToShorten('mypage.com'),
          throwsA(isA<BadRequestException>()));
    });

    test('Test 401 response', () async {
      client = MockClient((request) async {
        return http.Response(mock400Response, 401,
            headers: {'content-type': 'application/json'});
      });
      apiProvider = ApiProvider(httpClient: client);

      expect(apiProvider.postUrlToShorten('mypage.com'),
          throwsA(isA<UnauthorisedException>()));
    });

    test('Test 403 response', () async {
      client = MockClient((request) async {
        return http.Response(mock400Response, 403,
            headers: {'content-type': 'application/json'});
      });
      apiProvider = ApiProvider(httpClient: client);

      expect(apiProvider.postUrlToShorten('mypage.com'),
          throwsA(isA<UnauthorisedException>()));
    });

    test('Test 404 response', () async {
      client = MockClient((request) async {
        return http.Response(mock400Response, 404,
            headers: {'content-type': 'application/json'});
      });
      apiProvider = ApiProvider(httpClient: client);

      expect(apiProvider.postUrlToShorten('mypage.com'),
          throwsA(isA<FetchDataException>()));
    });

    test('Test 500 response', () async {
      client = MockClient((request) async {
        return http.Response(mock400Response, 500,
            headers: {'content-type': 'application/json'});
      });
      apiProvider = ApiProvider(httpClient: client);

      expect(apiProvider.postUrlToShorten('mypage.com'),
          throwsA(isA<FetchDataException>()));
    });
  });

  tearDown(() {
    client.close();
  });
}
