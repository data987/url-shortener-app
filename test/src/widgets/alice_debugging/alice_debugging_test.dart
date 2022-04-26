import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:url_shortener_app/core/bloc/index.dart';
import 'package:url_shortener_app/environment_config.dart';
import 'package:url_shortener_app/src/widgets/index.dart';

import '../../../helpers/widget_base_tester.dart';

class MockUrlShortenBloc extends MockBloc<UrlShortenEvent, UrlShortenState>
    implements UrlShortenBloc {}

void main() {
  late UrlShortenBloc mockUrlShortenBloc;

  setUp(() async {
    mockUrlShortenBloc = MockUrlShortenBloc();
  });

  testWidgets('Testing alice debugging structure', (tester) async {
    await tester.pumpWidget(widgetBaseTester(BlocProvider.value(
      value: mockUrlShortenBloc,
      child: AliceDebugging(
          child: Container(width: 300, height: 500, color: Colors.white),
          debugging: EnvironmentConfig.envValue == 'DEV'),
    )));
    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });
}
