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
  });
}
