import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener_app/environment_config.dart';

import 'core/api/http_requests.dart';
import 'core/bloc/index.dart';
import 'core/repositories/http_repositories.dart';
import 'src/ui/home.dart';
import 'src/widgets/index.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UrlShortenBloc>(
      create: (_) => UrlShortenBloc(homeRepository: homeRepository),
      child: MaterialApp(
        title: 'Url Shortener',
        navigatorKey: navigationKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AliceDebugging(
            child: HomeUi(), debugging: EnvironmentConfig.envValue == 'PROD'),
      ),
    );
  }
}
