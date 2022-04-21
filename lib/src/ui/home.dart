import 'package:flutter/material.dart';

import '../utils/extension_methods.dart';

class HomeUi extends StatelessWidget {
  const HomeUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Url Shortener'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            'Hola mundo!',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ).center(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
