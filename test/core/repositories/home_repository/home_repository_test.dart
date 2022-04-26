import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_app/core/api/api_provider.dart';
import 'package:url_shortener_app/core/models/index.dart';
import 'package:url_shortener_app/core/repositories/repositories.dart';

const Map<String, dynamic> mockResponse = {
  "alias": "51534",
  "_links": {
    "self": "www.facebook.com",
    "short": "https://url-shortener-nu.herokuapp.com/short/51534"
  }
};

class MockApiProvider extends Mock implements ApiProvider {}

void main() {
  late ApiProvider mockApiProvider;
  late HomeRepository homeRepository;

  setUp(() {
    mockApiProvider = MockApiProvider();
    homeRepository = HomeRepository(apiProvider: mockApiProvider);
  });

  test('Test home request', () async {
    when(() => mockApiProvider.postUrlToShorten('mypage.com'))
        .thenAnswer((_) async => mockResponse);
    expect(
        await homeRepository.postUrlToShorten(urlToShorten: 'mypage.com'),
        isA<UrlShorten>()
            .having((u) => u.alias, 'Check Alias', mockResponse['alias']));
  });
}
