import 'dart:ui';
import 'dart:math' as math;

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
  double minHeight = 1;
  double maxHeight = 200;
  double initHeight = 1;
  AnimationController _controller;
  Animation<double> widthTween;
  Animation<double> bottomTween;
  double get maxWidth => MediaQuery.of(context).size.width;

  bool animationGoingOn;
  bool animationOver;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value);

  @override
  Widget build(BuildContext context) {
    widthTween = Tween(begin: 120.0, end: MediaQuery.of(context).size.width)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
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
                  if (_controller.status == AnimationStatus.dismissed) {
                    _controller.forward();
                  } else if (_controller.status == AnimationStatus.forward) {
                    handleAnimation();
                  } else if (_controller.status == AnimationStatus.completed) {
                    afterAnimationOver();
                  } else {
                    print(_controller.value);
                  }
                },
                child: Icon(Icons.attach_file),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: <Widget>[
                    Container(
                      height: lerp(minHeight, maxHeight),
                      width: widthTween.value,
                      color: Colors.grey[200],
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 65),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MaterialButton(
                              padding: EdgeInsets.all(12.0),
                              child: new Icon(Icons.file_upload,
                                  color: Colors.white, size: 28.0),
                              onPressed: () {},
                              shape: new CircleBorder(),
                              elevation: 2.0,
                              color: Colors.black,
                            ),
                            MaterialButton(
                              padding: EdgeInsets.all(12.0),
                              child: new Icon(Icons.image,
                                  color: Colors.white, size: 28.0),
                              onPressed: () {},
                              shape: new CircleBorder(),
                              elevation: 2.0,
                              color: Colors.black,
                            ),
                            MaterialButton(
                              padding: EdgeInsets.all(12.0),
                              child: new Icon(Icons.videocam,
                                  color: Colors.white, size: 28.0),
                              onPressed: () {},
                              shape: new CircleBorder(),
                              elevation: 2.0,
                              color: Colors.black,
                            ),
                          ],
                        )),
                  ],
                );
              },
            )
          ],
        ));
  }

  void handleAnimation() {
    //need the controller to show or [visible=true] the three overlaying stacked buttons while animation
  }

  void afterAnimationOver() {
    //need to wait for another click on the attach_file button, so when it is clicked, it can roll back the animation & all the buttons will hide
  }
}
