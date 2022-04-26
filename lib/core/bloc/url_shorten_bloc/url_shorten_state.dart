part of 'url_shorten_bloc.dart';

enum UrlShortenStatus { initial, loading, shortenSuccess, failure }

extension UrlShortenStatusTest on UrlShortenStatus {
  bool get isInitial => this == UrlShortenStatus.initial;
  bool get isLoading => this == UrlShortenStatus.loading;
  bool get isShortenSuccess => this == UrlShortenStatus.shortenSuccess;
  bool get isFailure => this == UrlShortenStatus.failure;
}

class UrlShortenState extends Equatable {
  const UrlShortenState({
    this.status = UrlShortenStatus.initial,
    required this.urlShortenHistory,
  });

  final UrlShortenStatus status;
  final UrlHistoryModel urlShortenHistory;

  UrlShortenState copyWith({
    UrlShortenStatus? status,
    UrlHistoryModel? urlShortenHistory,
  }) {
    return UrlShortenState(
      status: status ?? this.status,
      urlShortenHistory: urlShortenHistory ?? this.urlShortenHistory,
    );
  }

  @override
  String toString() {
    return 'UrlState: { status: $status, urls: ${urlShortenHistory.urlShortenList} }';
  }

  @override
  List<Object?> get props => [status, urlShortenHistory];
}
