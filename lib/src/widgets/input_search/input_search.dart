import 'package:flutter/material.dart';
import 'package:url_shortener_app/src/utils/extension_methods.dart';

import '../../utils/size_config.dart';

class InputSearch extends StatefulWidget {
  const InputSearch({Key? key, required this.onChange}) : super(key: key);

  final Function(String) onChange;

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controller,
        ).container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            width: SizeConfig.blockSizeHorizontal * 80),
        IconButton(
          onPressed: () => widget.onChange(controller.text),
          icon: const Icon(Icons.send),
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
