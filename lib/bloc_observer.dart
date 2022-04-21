import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  final Logger logger = Logger(
    printer: PrettyPrinter(
      colors: false,
      errorMethodCount: 1,
      printEmojis: true,
      printTime: true,
      lineLength: 80,
      methodCount: 0,
    ),
  );

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.i('event: $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.v({
      'currentState': '${change.currentState}',
      'runtimeType': '${bloc.runtimeType}',
      'nextState': '${change.nextState}'
    });
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.v({
      'currentState': '${transition.currentState}',
      'event': '${transition.event}',
      'nextState': '${transition.nextState}'
    });
  }
}
