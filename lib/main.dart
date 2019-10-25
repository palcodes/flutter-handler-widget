import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handler',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Handler Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  double minHeight = 50;
  double maxHeight = 120;
  double initHeight = 20;
  AnimationController _controller;
  Animation<double> widthTween;
  Animation<double> bottomTween;
  double get maxWidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double lerp(double min, double max) => lerpDouble(min, max, _controller.value);

  @override
  Widget build(BuildContext context) {
    widthTween = Tween(begin: 120.0, end: MediaQuery.of(context).size.width).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.linearToEaseOut.flipped,
      ));
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () {
                  _controller.forward();
                },
                child: Icon(Icons.attach_file),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
              color: Colors.black,
              height: 20,
              width: 20,
                );
              },
            )
          ],
        ));
  }
}
