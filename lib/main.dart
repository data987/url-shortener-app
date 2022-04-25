import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_shortener_app/app.dart';

import 'bloc_observer.dart';

Future<HydratedStorage> pathStorage() async {
  WidgetsFlutterBinding.ensureInitialized();
  return HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
}

void main() async {
  HydratedBlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: AppBlocObserver(),
    storage: await pathStorage(),
  );
}
