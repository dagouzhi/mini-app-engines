/*
 * Copyright (C) 2022-present The Kraken authors. All rights reserved.
 */
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kraken/css.dart';
import 'package:kraken/kraken.dart';
// import 'package:kraken/devtools.dart';
import 'package:kraken_websocket/kraken_websocket.dart';
import 'package:kraken_animation_player/kraken_animation_player.dart';
import 'package:kraken_webview/kraken_webview.dart';
import 'package:kraken_video_player/kraken_video_player.dart';

void main() {
  KrakenWebsocket.initialize();
  KrakenAnimationPlayer.initialize();
  KrakenWebView.initialize();
  KrakenVideoPlayer.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kraken Browser',
      // theme: ThemeData.dark(),
      home: MyBrowser(),
    );
  }
}

class MyBrowser extends StatefulWidget {
  MyBrowser({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyBrowser> {
  OutlineInputBorder outlineBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  );
  String _url = "";
  final MethodChannel _channel_1 = const MethodChannel('__native2flutter__');
  final TextEditingController textEditingController =
      TextEditingController(text: '');
  Kraken? _kraken;
  @override
  void initState() {
    _channel_1.setMethodCallHandler((call) {
      if (call.method == 'open_url') {
        setState(() {
          _url = call.arguments;
          // _kraken?.load(KrakenBundle.fromUrl(_url));
        });
      }
      if (call.method == 'close_url') {
        setState(() {
          _url = "";
          SystemNavigator.pop(animated: true);
        });
      }
      if (call.method == 'CUSTOM_EVENT') {
        // call.arguments
      }

      return Future.value('_channel_1: ok');
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    // text: Uri.decodeFull(window.defaultRouteName)
    final Size viewportSize = queryData.size;
    var height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
        body: _url.isNotEmpty
            ? Center(
                child: _kraken = Kraken(
                background: Colors.white,
                // devToolsService: ChromeDevToolsService(),
                viewportWidth: viewportSize.width,
                viewportHeight: viewportSize.height,
                bundle: KrakenBundle.fromUrl(_url),
              ))
            : const Center(
                child: Text('loading'),
              ),
        floatingActionButton: SizedBox(
          width: 90,
          height: 32,
          child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5)
                ],
              ),
              child: Flex(direction: Axis.horizontal, children: [
                Expanded(
                  flex: 2,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 16,
                      color: Colors.black87,
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  width: 1,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(
                        Icons.adjust,
                        size: 16,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _url = "";
                        });
                        SystemNavigator.pop(animated: true);
                      },
                    )),
              ])),
        ),
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(
            FloatingActionButtonLocation.endTop, 0, 10));
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  FloatingActionButtonLocation location;
  double offsetX; // X方向的偏移量
  double offsetY; // Y方向的偏移量
  CustomFloatingActionButtonLocation(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}
