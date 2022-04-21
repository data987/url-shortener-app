part of 'url_shorten_bloc.dart';

abstract class UrlShortenEvent extends Equatable {
  const UrlShortenEvent();

  @override
  List<Object> get props => [];
}

class UrlsShortenFetch extends UrlShortenEvent {}
