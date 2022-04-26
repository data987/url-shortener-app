import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:url_shortener_app/src/widgets/index.dart';
import 'package:url_shortener_app/src/utils/extension_methods.dart';

import '../../../helpers/widget_base_tester.dart';

void main() {
  testWidgets('Testing main structure', (tester) async {
    await tester.pumpWidget(widgetBaseTester(
      InputSearch(onPressed: (value) {}).container(width: 200).material(),
    ));
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });

  testWidgets('Testing the value when the user pressed the button',
      (tester) async {
    String currentSearch = '';
    await tester.pumpWidget(widgetBaseTester(
      InputSearch(onPressed: (value) => currentSearch = value)
          .container(width: 200)
          .material(),
    ));

    await tester.enterText(find.byType(TextField), 'eyesbook.com');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('eyesbook.com'), findsOneWidget);
    await tester.tap(find.byType(IconButton));
    expect(currentSearch, equals('eyesbook.com'));
  });
}
