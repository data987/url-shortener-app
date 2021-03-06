import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener_app/src/widgets/index.dart';

import '../../core/bloc/index.dart';
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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InputSearch(
            onPressed: (value) =>
                context.read<UrlShortenBloc>().add(UrlsShortenFetch(value)),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Recently shortened URLs',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ).paddingOnly(bottom: 30),
              BlocBuilder<UrlShortenBloc, UrlShortenState>(
                  builder: ((context, state) {
                switch (state.status) {
                  case UrlShortenStatus.shortenSuccess:
                    return CustomAnimateList(
                      urlList: state.urlShortenHistory.urlShortenList,
                      onDelete: (item) => context
                          .read<UrlShortenBloc>()
                          .add(RemovesUrl(item.alias)),
                    );
                  case UrlShortenStatus.loading:
                    return const CircularProgressIndicator().center();
                  default:
                    return const Text('There is no urls shorten').center();
                }
              })).flexible(),
            ],
          ).paddingOnly(top: 20.0, left: 30.0, right: 30.0).expanded(),
        ],
      ).paddingOnly(top: 25.0),
    );
  }
}
