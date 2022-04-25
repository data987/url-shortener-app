import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:url_shortener_app/core/repositories/repositories.dart';

import '../../models/index.dart';

part 'url_shorten_event.dart';
part 'url_shorten_state.dart';

class UrlShortenBloc extends HydratedBloc<UrlShortenEvent, UrlShortenState> {
  UrlShortenBloc({required this.homeRepository})
      : super(UrlShortenState(
            urlShortenHistory: UrlHistoryModel(urlShortenList: []))) {
    on<UrlsShortenFetch>(_onPostUrlToShorten);
    on<RemovesUrl>(_removesUrlFromTheList);
  }

  final HomeRepository homeRepository;

  FutureOr<void> _onPostUrlToShorten(
      UrlsShortenFetch event, Emitter<UrlShortenState> emit) async {
    try {
      if (state.status == UrlShortenStatus.initial) {
        emit(state.copyWith(status: UrlShortenStatus.loading));
        final UrlShorten getUrlShorten = await _fetchUrlShorten(event.url);
        emit(state.copyWith(
          status: UrlShortenStatus.shortenSuccess,
          urlShortenHistory: UrlHistoryModel(urlShortenList: [getUrlShorten]),
        ));
      } else {
        final UrlShorten getNewUrls = await _fetchUrlShorten(event.url);
        emit(state.copyWith(
            status: UrlShortenStatus.shortenSuccess,
            urlShortenHistory: UrlHistoryModel(urlShortenList: [
              getNewUrls,
              ...state.urlShortenHistory.urlShortenList
            ])));
      }
    } catch (_) {
      emit(state.copyWith(status: UrlShortenStatus.failure));
    }
  }

  Future<UrlShorten> _fetchUrlShorten(String url) async {
    final UrlShorten getUrlShorten =
        await homeRepository.postUrlToShorten(urlToShorten: url);
    return getUrlShorten;
  }

  FutureOr<void> _removesUrlFromTheList(
      RemovesUrl event, Emitter<UrlShortenState> emit) async {
    if (state.urlShortenHistory.urlShortenList.isNotEmpty) {
      state.urlShortenHistory.urlShortenList
          .removeWhere((url) => url.alias == event.alias);
    }
    emit(
      state.copyWith(
          status: UrlShortenStatus.shortenSuccess,
          urlShortenHistory: UrlHistoryModel(
            urlShortenList: state.urlShortenHistory.urlShortenList,
          )),
    );
  }

  @override
  UrlShortenState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty && json['url-shorten-list'].isNotEmpty) {
      final jsonToModel = UrlHistoryModel.fromJson(json);
      return UrlShortenState(
          status: UrlShortenStatus.shortenSuccess,
          urlShortenHistory: jsonToModel);
    } else {
      return UrlShortenState(
          status: UrlShortenStatus.initial,
          urlShortenHistory: UrlHistoryModel(urlShortenList: []));
    }
  }

  @override
  Map<String, dynamic>? toJson(UrlShortenState state) {
    if (state.status == UrlShortenStatus.shortenSuccess) {
      return state.urlShortenHistory.toJson();
    } else {
      return null;
    }
  }
}
