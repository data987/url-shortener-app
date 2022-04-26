import 'package:flutter/material.dart';
import '../../../core/models/url_shorten_model.dart';

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
            Row(
              children: [
                const Text(
                  'Alias: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  item.alias,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Url: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  item.links?.self ?? 'There is no url',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Text(
              'Short: ',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              item.links?.short ?? 'There is no url shorten',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextButton.icon(
                key: Key('remove-item-${item.alias}-button'),
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.red[400],
                ),
                label: Text('Delete item',
                    style: TextStyle(fontSize: 15, color: Colors.red[400])))
          ],
        ),
      ),
    );
  }
}
