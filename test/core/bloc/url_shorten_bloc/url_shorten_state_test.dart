import 'package:flutter_test/flutter_test.dart';
import 'package:url_shortener_app/core/bloc/url_shorten_bloc/url_shorten_bloc.dart';

void main() {
  group('Testing UrlShortenStatus', () {
    test('return correct values for UrlShortenStatus.initial', () {
      const status = UrlShortenStatus.initial;
      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isShortenSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('return correct values for UrlShortenStatus.loading', () {
      const status = UrlShortenStatus.loading;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isShortenSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('return correct values for UrlShortenStatus.shortenSuccess', () {
      const status = UrlShortenStatus.shortenSuccess;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isShortenSuccess, isTrue);
      expect(status.isFailure, isFalse);
    });

    test('return correct values for UrlShortenStatus.failure', () {
      const status = UrlShortenStatus.failure;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isShortenSuccess, isFalse);
      expect(status.isFailure, isTrue);
    });
  });
}
