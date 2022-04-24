import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener_app/src/widgets/index.dart';

import '../../core/bloc/index.dart';
import '../utils/extension_methods.dart';
import '../utils/size_config.dart';

class HomeUi extends StatelessWidget {
  const HomeUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Url Shortener'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InputSearch(
            onChange: (value) =>
                context.read<UrlShortenBloc>().add(UrlsShortenFetch(value)),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Recently shortened URLs'),
              BlocBuilder<UrlShortenBloc, UrlShortenState>(
                  builder: ((context, state) {
                switch (state.status) {
                  case UrlShortenStatus.shortenSuccess:
                    return CustomAnimateList(
                      urlList: state.urlShortenHistory.urlShortenList,
                    );
                  case UrlShortenStatus.loading:
                    return const CircularProgressIndicator().center();
                  default:
                    return const Text('There is no urls shorten').center();
                }
              })).flexible(),
            ],
          ).paddingOnly(top: 20.0).expanded(),
        ],
      ).paddingOnly(top: 25.0),
    );
  }
}
