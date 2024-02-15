import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children:[
              WebView(
              initialUrl: 'https://www.izko.org.tr/Home/GuncelKur',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
            ),
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    // Handle touch events here
                  },
                  behavior: HitTestBehavior.opaque, // This ensures that the gesture detector consumes all touches
                ),
              ),
            ]
          ),
        ),
      ],
    );
  }
}