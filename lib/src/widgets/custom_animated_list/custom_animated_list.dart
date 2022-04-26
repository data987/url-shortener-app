import 'package:flutter/material.dart';

import '../../../core/models/url_shorten_model.dart';
import '../card_item/card_item.dart';

class CustomAnimateList extends StatefulWidget {
  const CustomAnimateList(
      {Key? key, required this.urlList, required this.onDelete})
      : super(key: key);

  final List<UrlShorten> urlList;
  final Function(UrlShorten) onDelete;

  @override
  State<CustomAnimateList> createState() => _CustomAnimateListState();
}

class _CustomAnimateListState extends State<CustomAnimateList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void didUpdateWidget(covariant CustomAnimateList oldWidget) {
    if (oldWidget.urlList.length < widget.urlList.length) {
      _listKey.currentState
          ?.insertItem(0, duration: const Duration(milliseconds: 500));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: _listKey,
        initialItemCount: widget.urlList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          return _buildItem(context,
              index: index, item: widget.urlList[index], animation: animation);
        });
  }

  Widget _buildItem(context,
      {int? index, UrlShorten? item, required Animation<double> animation}) {
    return CardItem(
      animation: animation,
      item: item!,
      onDelete: () => _deleteItem(context, index!, animation),
    );
  }

  _deleteItem(BuildContext context, int index, Animation<double> animation) {
    UrlShorten item = widget.urlList.removeAt(index);
    AnimatedList.of(context).removeItem(index, (context, animation) {
      return FadeTransition(
        opacity:
            CurvedAnimation(parent: animation, curve: const Interval(0.5, 1.0)),
        child: SizeTransition(
          sizeFactor: CurvedAnimation(
              parent: animation, curve: const Interval(0.0, 1.0)),
          axisAlignment: 0.0,
          child: _buildItem(context, item: item, animation: animation),
        ),
      );
    }, duration: const Duration(milliseconds: 500));
    Future.delayed(const Duration(milliseconds: 300), () {
      return widget.onDelete(item);
    });
  }
}
