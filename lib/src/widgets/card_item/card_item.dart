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
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Alias: ${item.alias}'),
            Text(
              'Url: ${item.links?.self ?? 'There is no url'}',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4,
              ),
            ),
            Text('Short: ${item.links?.short ?? 'There is no url shorten'}',
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                )),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.copy))
                    .paddingOnly(right: 25.0),
                IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline_outlined))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
