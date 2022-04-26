import 'package:flutter_test/flutter_test.dart';
import 'package:url_shortener_app/core/api/custom_exceptions.dart';

void main() {
  group('Test api provider', () {
    String responseMock = 'Response mock';

    test('Test FetchDataException response', () {
      expect(() => throw FetchDataException(responseMock),
          throwsA(isA<FetchDataException>()));

      expect(
          () => throw FetchDataException(responseMock),
          throwsA(predicate(
              (e) => e is FetchDataException && e.message == responseMock)));
    });

    test('Test BadRequestException response', () {
      expect(() => throw BadRequestException(responseMock),
          throwsA(isA<BadRequestException>()));

      expect(
          () => throw BadRequestException(responseMock),
          throwsA(predicate(
              (e) => e is BadRequestException && e.message == responseMock)));
    });

    test('Test UnauthorisedException response', () {
      expect(() => throw UnauthorisedException(responseMock),
          throwsA(isA<UnauthorisedException>()));

      expect(
          () => throw UnauthorisedException(responseMock),
          throwsA(predicate(
              (e) => e is UnauthorisedException && e.message == responseMock)));
    });

    test('Test InvalidInputException response', () {
      expect(() => throw InvalidInputException(responseMock),
          throwsA(isA<InvalidInputException>()));

      expect(
          () => throw InvalidInputException(responseMock),
          throwsA(predicate(
              (e) => e is InvalidInputException && e.message == responseMock)));
    });

    test('Test NotFoundException response', () {
      expect(() => throw NotFoundException(responseMock),
          throwsA(isA<NotFoundException>()));

      expect(
          () => throw NotFoundException(responseMock),
          throwsA(predicate(
              (e) => e is NotFoundException && e.message == responseMock)));
    });
  });
}
