part of 'url_shorten_bloc.dart';

abstract class UrlShortenEvent extends Equatable {
  const UrlShortenEvent();

  @override
  List<Object> get props => [];
}

class UrlsShortenFetch extends UrlShortenEvent {
  const UrlsShortenFetch(this.url);

  final String url;

  @override
  List<Object> get props => [url];
}

class RemovesUrl extends UrlShortenEvent {
  const RemovesUrl(this.alias);

  final String alias;

  @override
  List<Object> get props => [alias];
}
