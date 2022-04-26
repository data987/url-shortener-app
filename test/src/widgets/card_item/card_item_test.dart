import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:url_shortener_app/core/models/index.dart';
import 'package:url_shortener_app/src/widgets/index.dart';
import 'package:url_shortener_app/src/utils/extension_methods.dart';

import '../../../helpers/widget_base_tester.dart';

void main() {
  testWidgets('card item structure', (tester) async {
    await tester.pumpWidget(widgetBaseTester(
      CardItem(
        animation: AnimationController(vsync: const TestVSync()),
        item: UrlShorten(
            alias: '1234',
            links: Links(
              self: 'url.com',
              short: 'short-url.com/alias/1234',
            )),
        onDelete: () {},
      ).material(),
    ));
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(7));
    expect(find.byKey(const Key('remove-item-1234-button')), findsOneWidget);
  });

  testWidgets('Test onPressed button', (tester) async {
    final List<int> log = [];
    void _onPressed() => log.add(1);

    await tester.pumpWidget(widgetBaseTester(
      CardItem(
        animation: AnimationController(vsync: const TestVSync()),
        item: UrlShorten(
            alias: '1234',
            links: Links(
              self: 'url.com',
              short: 'short-url.com/alias/1234',
            )),
        onDelete: _onPressed,
      ).material(),
    ));
    await tester.tap(find.byKey(const Key('remove-item-1234-button')));
    await tester.tap(find.byKey(const Key('remove-item-1234-button')));
    expect(log.length, 2);
    await tester.tap(find.byKey(const Key('remove-item-1234-button')));
    await tester.tap(find.byKey(const Key('remove-item-1234-button')));
    expect(log.length, 4);
  });
}
