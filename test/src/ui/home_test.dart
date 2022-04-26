import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_app/core/bloc/index.dart';
import 'package:url_shortener_app/core/models/url_shorten_model.dart';
import 'package:url_shortener_app/core/repositories/repositories.dart';
import 'package:url_shortener_app/src/ui/home.dart';
import 'package:url_shortener_app/src/widgets/index.dart';

import '../../helpers/widget_base_tester.dart';
import '../../mocks.dart';

class MockHomRepository extends Mock implements HomeRepository {}

class MockUrlShortenBloc extends MockBloc<UrlShortenEvent, UrlShortenState>
    implements UrlShortenBloc {}

void main() {
  late HomeRepository mockWeatherRepository;
  late UrlShortenBloc mockUrlShortenBloc;

  setUp(() async {
    mockWeatherRepository = MockHomRepository();
    mockUrlShortenBloc = MockUrlShortenBloc();
  });

  group('Test home structure and different renders', () {
    testWidgets('Testing main home structure', (tester) async {
      await tester.pumpWidget(widgetBaseTester(BlocProvider.value(
        value: UrlShortenBloc(homeRepository: mockWeatherRepository),
        child: const HomeUi(),
      )));
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(Column), findsNWidgets(2));
      expect(find.byType(InputSearch), findsOneWidget);
    });

    testWidgets('Find text when the state is initial', (tester) async {
      when(() => mockUrlShortenBloc.state).thenReturn(UrlShortenState(
        status: UrlShortenStatus.initial,
        urlShortenHistory: UrlHistoryModel(urlShortenList: []),
      ));
      await tester.pumpWidget(widgetBaseTester(
        BlocProvider.value(
          value: mockUrlShortenBloc,
          child: const HomeUi(),
        ),
      ));
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.text('There is no urls shorten'), findsOneWidget);
    });

    testWidgets('Find Circular Indicator when the state is loading',
        (tester) async {
      when(() => mockUrlShortenBloc.state).thenReturn(UrlShortenState(
        status: UrlShortenStatus.loading,
        urlShortenHistory: UrlHistoryModel(urlShortenList: []),
      ));
      await tester.pumpWidget(widgetBaseTester(
        BlocProvider.value(
          value: mockUrlShortenBloc,
          child: const HomeUi(),
        ),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Find Custom Animated List when the state is loading',
        (tester) async {
      when(() => mockUrlShortenBloc.state).thenReturn(UrlShortenState(
        status: UrlShortenStatus.shortenSuccess,
        urlShortenHistory: UrlHistoryModel(urlShortenList: [
          UrlShorten(
            alias: '1234',
            links: Links(
              self: 'url.com',
              short: 'url.com/1234',
            ),
          )
        ]),
      ));
      await tester.pumpWidget(widgetBaseTester(
        BlocProvider.value(
          value: mockUrlShortenBloc,
          child: const HomeUi(),
        ),
      ));
      expect(find.byType(CustomAnimateList), findsOneWidget);
    });

    testWidgets('Testing search input', (tester) async {
      when(() => mockUrlShortenBloc.state).thenReturn(UrlShortenState(
          status: UrlShortenStatus.shortenSuccess,
          urlShortenHistory: urlHistoryModelMock));
      await tester.pumpWidget(widgetBaseTester(
        RepositoryProvider.value(
          value: mockWeatherRepository,
          child: BlocProvider.value(
            value: mockUrlShortenBloc,
            child: const HomeUi(),
          ),
        ),
      ));

      await tester.enterText(
          find.byKey(const Key('text-field-search')), 'mypage.com');
      await tester.tap(find.byKey(const Key('search-button')));
      verify(() => mockUrlShortenBloc.add(const UrlsShortenFetch('mypage.com')))
          .called(1);
      expect(find.text('mypage.com'), findsOneWidget);
      expect(find.text("1234"), findsOneWidget);
    });

    testWidgets('Testing when the user removes an url from the history',
        (tester) async {
      when(() => mockUrlShortenBloc.state).thenReturn(UrlShortenState(
          status: UrlShortenStatus.shortenSuccess,
          urlShortenHistory: urlHistoryModelMock));
      await tester.pumpWidget(widgetBaseTester(
        RepositoryProvider.value(
          value: mockWeatherRepository,
          child: BlocProvider.value(
            value: mockUrlShortenBloc,
            child: const HomeUi(),
          ),
        ),
      ));

      expect(find.byKey(const Key('remove-item-1234-button')), findsOneWidget);
      await tester.tap(find.byKey(const Key('remove-item-1234-button')));
      await tester.pumpAndSettle();
      verify(() => mockUrlShortenBloc.add(const RemovesUrl('1234'))).called(1);
      expect(find.text('mypage.com'), findsNothing);
      expect(find.text("1234"), findsNothing);
    });
  });
}
