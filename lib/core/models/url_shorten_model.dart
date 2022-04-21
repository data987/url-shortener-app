import 'dart:convert';

UrlHistoryModel urlShortenModelFromJson(String str) =>
    UrlHistoryModel.fromJson(json.decode(str));

String urlShortenModelToJson(UrlHistoryModel data) =>
    json.encode(data.toJson());

class UrlHistoryModel {
  const UrlHistoryModel({required this.urlShorten});

  final List<UrlShorten> urlShorten;

  factory UrlHistoryModel.fromJson(Map<String, dynamic> json) =>
      UrlHistoryModel(
        urlShorten: List<UrlShorten>.from(
          json['url-shorten']
              .map((url) => UrlShorten.fromJson(json['url-shorten'])),
        ),
      );

  Map<String, dynamic> toJson() => {'url-shorten': urlShorten};
}

class UrlShorten {
  UrlShorten({
    required this.alias,
    this.links,
  });

  final String alias;
  final Links? links;

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
