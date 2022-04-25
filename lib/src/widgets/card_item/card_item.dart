import 'package:flutter/material.dart';
import '../../../core/models/url_shorten_model.dart';
import '../../utils/extension_methods.dart';
import '../../utils/size_config.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.item,
    required this.animation,
    required this.onDelete,
  }) : super(key: key);

  final UrlShorten item;
  final Animation<double> animation;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizeTransition(
      key: key,
      sizeFactor: animation,
      child: Container(
        padding: const EdgeInsets.only(
          top: 20.0,
          right: 25.0,
          bottom: 10,
          left: 25.0,
        ),
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: 'Alias: ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: item.alias,
                        style: const TextStyle(fontWeight: FontWeight.w400))
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: 'Url: ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: item.links?.self ?? 'There is no url',
                        style: const TextStyle(fontWeight: FontWeight.w400))
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: 'Short:\n',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: item.links?.short ?? 'There is no url shorten',
                        style: const TextStyle(fontWeight: FontWeight.w400))
                  ]),
            ),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.copy))
                    .paddingOnly(right: 10.0),
                IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_outline_outlined,
                      color: Colors.red[400],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
