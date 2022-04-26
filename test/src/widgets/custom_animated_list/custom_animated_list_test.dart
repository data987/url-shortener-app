import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:url_shortener_app/core/models/index.dart';
import 'package:url_shortener_app/src/widgets/index.dart';
import 'package:url_shortener_app/src/utils/extension_methods.dart';

import '../../../helpers/widget_base_tester.dart';

void main() {
  final List<UrlShorten> urlList = [
    UrlShorten(
        alias: '1234',
        links: Links(self: 'url.com', short: 'short.com/alias/1234')),
    UrlShorten(
        alias: '9876',
        links: Links(self: 'data.com', short: 'short.com/alias/9876'))
  ];
  testWidgets('Testing delete action', (tester) async {
    String aliasRemoved = '';
    await tester.pumpWidget(widgetBaseTester(
      CustomAnimateList(
        urlList: urlList,
        onDelete: (item) => aliasRemoved = item.alias,
      ).material(),
    ));
    expect(find.byType(CardItem), findsNWidgets(2));
    await tester.tap(find.byKey(Key('remove-item-${urlList[1].alias}-button')));
    await tester.pumpAndSettle();
    expect(find.byType(CardItem), findsOneWidget);
    expect(aliasRemoved, '9876');
  });
}
