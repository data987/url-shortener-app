import 'package:url_shortener_app/core/models/index.dart';

UrlShorten fetchUrlMock = UrlShorten(
    alias: '1234',
    links: Links(self: 'mypage.com', short: 'short.com/alias/1234'));

UrlShorten fetchUrlDataMock = UrlShorten(
    alias: '9876',
    links: Links(self: 'data.io', short: 'short.com/alias/9876'));

final UrlHistoryModel urlHistoryModelMock =
    UrlHistoryModel(urlShortenList: [fetchUrlMock]);
