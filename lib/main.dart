import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener_app/app.dart';

import 'bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: AppBlocObserver(),
  );
}
