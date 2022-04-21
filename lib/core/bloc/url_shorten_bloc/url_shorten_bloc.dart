import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/index.dart';

part 'url_shorten_event.dart';
part 'url_shorten_state.dart';

class UrlShortenBloc extends HydratedBloc<UrlShortenEvent, UrlShortenState> {
  UrlShortenBloc() : super(const UrlShortenState()) {
    on<UrlShortenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  @override
  UrlShortenState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(UrlShortenState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
