import 'package:flutter/material.dart';
import 'package:url_shortener_app/src/utils/extension_methods.dart';

import '../../utils/size_config.dart';

class InputSearch extends StatefulWidget {
  const InputSearch({Key? key, required this.onPressed}) : super(key: key);

  final Function(String) onPressed;

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  late TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _textController,
        ).container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
          width: SizeConfig.blockSizeHorizontal * 80,
        ),
        IconButton(
          onPressed: () {
            widget.onPressed(_textController.text);
            _textController.clear();
          },
          icon: const Icon(Icons.send),
        )
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
