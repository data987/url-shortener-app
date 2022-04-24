import 'dart:convert';

UrlHistoryModel urlShortenModelFromJson(String str) =>
    UrlHistoryModel.fromJson(json.decode(str));

String urlShortenModelToJson(UrlHistoryModel data) =>
    json.encode(data.toJson());

class UrlHistoryModel {
  UrlHistoryModel({required this.urlShortenList});

  List<UrlShorten> urlShortenList;

  factory UrlHistoryModel.fromJson(Map<String, dynamic> json) =>
      UrlHistoryModel(
        urlShortenList: List<UrlShorten>.from(
          json['url-shorten-list'].map((url) => UrlShorten.fromJson(url)),
        ),
      );

  Map<String, dynamic> toJson() => {'url-shorten-list': urlShortenList};
}

class UrlShorten {
  UrlShorten({
    required this.alias,
    this.links,
  });

  String alias;
  Links? links;

  factory UrlShorten.fromJson(Map<String, dynamic> json) => UrlShorten(
        alias: json['alias'],
        links: json['_links'] == null ? null : Links.fromJson(json['_links']),
      );

  Map<String, dynamic> toJson() => {
        'alias': alias,
        '_links': links?.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.short,
  });

  final String? self;
  final String? short;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json['self'],
        short: json['short'],
      );

  Map<String, dynamic> toJson() => {
        'self': self,
        'short': short,
      };
}
