import 'package:flutter/material.dart';
import 'package:url_shortener_app/src/utils/size_config.dart';

import '../../../core/api/http_requests.dart';

class AliceDebugging extends StatelessWidget {
  const AliceDebugging({
    Key? key,
    required this.child,
    required this.debugging,
  }) : super(key: key);

  final Widget child;
  final bool debugging;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Offset position = const Offset(30.0, 30.0);

    return Stack(
      children: [
        child,
        if (debugging) ...[
          Positioned(
              left: SizeConfig.blockSizeHorizontal * 40,
              top: position.dy,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepPurple),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)))),
                  child: const Icon(
                    Icons.bug_report,
                    color: Colors.white,
                  ),
                  onPressed: () => alice.showInspector()))
        ]
      ],
    );
  }
}
