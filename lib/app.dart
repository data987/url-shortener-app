import 'package:flutter/material.dart';

import 'src/ui/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Url Shortener',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeUi(),
    );
  }
}
