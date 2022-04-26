import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_app/core/api/api_environment.dart';
import 'package:url_shortener_app/core/api/api_provider.dart';
import 'package:url_shortener_app/core/api/api_responses.dart';

const Map<String, dynamic> mockResponse = {
  "alias": "51534",
  "_links": {
    "self": "www.facebook.com",
    "short": "https://url-shortener-nu.herokuapp.com/short/51534"
  }
};

class MockHttpClient extends Mock implements http.Client {}

class MockLala extends Mock implements ApiProvider {}

void main() {
  late ApiProvider apiProvider;
  late http.Client client;

  setUp(() {
    client = MockHttpClient();
    apiProvider = MockLala();
  });

  // test('Test postUrlToShorten response', () async {
  //   when(
  //     () => client.post(
  //       Uri.parse('https://url-shortener-nu.herokuapp.com/api/alias'),
  //       body: {'url': 'mypage.com'},
  //       headers: {
  //         "Accept": "application/json",
  //         "content-type": "application/json",
  //       },
  //     ),
  //   ).thenAnswer(
  //     (_) => ApiResponses.apiResponses(
  //         http.Response(jsonEncode(mockResponse), 200)),
  //   );

  //   expect(await apiProvider.postUrlToShorten('mypage.com'), mockResponse);
  // });

  test('Test postUrlToShorten response', () async {
    when(() => apiProvider.postUrlToShorten('mypage.com')).thenAnswer(
      (_) async => mockResponse,
    );

    expect(await apiProvider.postUrlToShorten('mypage.com'), mockResponse);
  });

  tearDown(() {
    client.close();
  });
}
