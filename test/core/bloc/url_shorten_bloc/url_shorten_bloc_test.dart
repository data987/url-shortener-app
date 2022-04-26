import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_app/core/bloc/index.dart';
import 'package:url_shortener_app/core/models/index.dart';
import 'package:url_shortener_app/core/repositories/repositories.dart';

import '../../../helpers/hydrated_bloc_tester.dart';
import '../../../mocks.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late HomeRepository mockHomeRepository;
  late UrlShortenBloc urlShortenBloc;

  setUp(() async {
    mockHomeRepository = MockHomeRepository();
    urlShortenBloc = await mockHydratedStorage(
      () => UrlShortenBloc(homeRepository: mockHomeRepository),
    );
  });

  group('Testing when the user fetch urls to short', () {
    test('initial state is correct', () {
      mockHydratedStorage(() {
        expect(
            urlShortenBloc.state,
            isA<UrlShortenState>().having(
              (u) => u.status,
              'Status is initial',
              UrlShortenStatus.initial,
            ));
      });
    });

    blocTest<UrlShortenBloc, UrlShortenState>(
        'Current state is shorten success',
        build: () {
          when(() => mockHomeRepository.postUrlToShorten(
                  urlToShorten: 'mypage.com'))
              .thenAnswer((_) async => fetchUrlMock);
          return urlShortenBloc;
        },
        act: (bloc) => bloc.add(const UrlsShortenFetch('mypage.com')),
        expect: () => <dynamic>[
              isA<UrlShortenState>(),
              isA<UrlShortenState>().having(
                (u) => u.status,
                'Check status',
                UrlShortenStatus.shortenSuccess,
              )
            ]);

    blocTest<UrlShortenBloc, UrlShortenState>(
        'Current state is shorten failure',
        build: () {
          when(() => mockHomeRepository.postUrlToShorten(
                  urlToShorten: 'mypage.com'))
              .thenAnswer((_) async => fetchUrlMock);
          return UrlShortenBloc(homeRepository: mockHomeRepository);
        },
        act: (bloc) => bloc.add(const UrlsShortenFetch('mypage.com')),
        expect: () => <dynamic>[
              isA<UrlShortenState>().having(
                (u) => u.status,
                'Check status',
                UrlShortenStatus.loading,
              ),
              isA<UrlShortenState>().having(
                (u) => u.status,
                'Check status',
                UrlShortenStatus.failure,
              )
            ]);

    blocTest<UrlShortenBloc, UrlShortenState>(
        'check urlShortenHistory on success status',
        build: () {
          when(() => mockHomeRepository.postUrlToShorten(
                  urlToShorten: 'mypage.com'))
              .thenAnswer((_) async => fetchUrlMock);
          return urlShortenBloc;
        },
        act: (bloc) => bloc.add(const UrlsShortenFetch('mypage.com')),
        expect: () => <dynamic>[
              isA<UrlShortenState>(),
              isA<UrlShortenState>().having(
                (u) => u.urlShortenHistory,
                'Url history model',
                isA<UrlHistoryModel>().having(
                  (uHistory) => uHistory.urlShortenList,
                  'Check url shorten list',
                  [fetchUrlMock],
                ),
              )
            ]);

    blocTest<UrlShortenBloc, UrlShortenState>(
        'Make multiple calls to get multitple urls shorten',
        build: () {
          when(() => mockHomeRepository.postUrlToShorten(
                  urlToShorten: 'mypage.com'))
              .thenAnswer((_) async => fetchUrlMock);
          when(() =>
                  mockHomeRepository.postUrlToShorten(urlToShorten: 'data.io'))
              .thenAnswer((_) async => fetchUrlDataMock);
          return urlShortenBloc;
        },
        act: (bloc) {
          bloc.add(const UrlsShortenFetch('mypage.com'));
          bloc.add(const UrlsShortenFetch('data.io'));
        },
        expect: () => <dynamic>[
              isA<UrlShortenState>(),
              isA<UrlShortenState>().having(
                (u) => u.urlShortenHistory,
                'Url short History',
                isA<UrlHistoryModel>().having(
                  (uHistory) => uHistory.urlShortenList,
                  'List UrlShorten',
                  isA<List<UrlShorten>>()
                      .having((list) => list[0].alias, 'Check List', '1234'),
                ),
              ),
              isA<UrlShortenState>().having(
                (u) => u.urlShortenHistory,
                'Url short History',
                isA<UrlHistoryModel>().having(
                  (uHistory) => uHistory.urlShortenList,
                  'List UrlShorten',
                  isA<List<UrlShorten>>()
                      .having((list) => list[0].alias, 'Check List', '9876'),
                ),
              ),
            ]);
  });

  group('Test when the user is going to remove an url from the history', () {
    blocTest<UrlShortenBloc, UrlShortenState>('Remove url from the history',
        build: () {
          when(() => mockHomeRepository.postUrlToShorten(
                  urlToShorten: 'mypage.com'))
              .thenAnswer((_) async => fetchUrlMock);
          when(() =>
                  mockHomeRepository.postUrlToShorten(urlToShorten: 'data.io'))
              .thenAnswer((_) async => fetchUrlDataMock);
          return urlShortenBloc;
        },
        act: (bloc) async {
          bloc
            ..add(const UrlsShortenFetch('mypage.com'))
            ..add(const UrlsShortenFetch('data.io'))
            ..add(const UrlsShortenFetch('data.io'))
            ..add(const RemovesUrl('1234'));
        },
        expect: () => <dynamic>[
              isA<UrlShortenState>(),
              isA<UrlShortenState>().having(
                (u) => u.urlShortenHistory,
                'Url shorten history',
                isA<UrlHistoryModel>().having(
                  (uHistory) => uHistory.urlShortenList.length,
                  'Shorten list',
                  1,
                ),
              ),
              isA<UrlShortenState>().having(
                (u) => u.urlShortenHistory,
                'Url shorten history',
                isA<UrlHistoryModel>().having(
                  (uHistory) => uHistory.urlShortenList.length,
                  'Shorten list',
                  2,
                ),
              ),
              isA<UrlShortenState>().having(
                (u) => u.urlShortenHistory,
                'Url shorten history',
                isA<UrlHistoryModel>().having(
                  (uHistory) => uHistory.urlShortenList.length,
                  'Shorten list',
                  2,
                ),
              ),
              isA<UrlShortenState>().having(
                (u) => u.urlShortenHistory,
                'Url shorten history',
                isA<UrlHistoryModel>().having(
                  (uHistory) => uHistory.urlShortenList.length,
                  'Shorten list',
                  2,
                ),
              ),
            ]);
  });
}
