import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(
//    new ToImageBug()
//    new BorderRadiusBug()
    new RowMaterialBugB()
);

/// issue: https://github.com/flutter/flutter/issues/18713
/// Was not happening on Flutter 0.5.5-pre.25 • channel master
/// Framework • revision 86ed141bef (7 days ago) • 2018-06-21 22:22:59 -0700
/// Engine • revision 549c855e89
/// Tools • Dart 2.0.0-dev.61.0.flutter-c95617b19c
/// But is happening on Flutter v0.5.6-pre.51,
class RowMaterialBugA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(color: Colors.green, width: 100.0, height: 100.0,),
        Material(borderRadius: BorderRadius.circular(3.0), child: Container(width: 100.0, height:100.0),),
        Container(color: Colors.red, width: 100.0, height: 100.0,),
        Container(color: Colors.blue, width: 100.0, height: 100.0,),
      ],
    );
  }
}

/// issue: https://github.com/flutter/flutter/issues/18713
/// Was not happening on Flutter 0.5.5-pre.25 • channel master
/// Framework • revision 86ed141bef (7 days ago) • 2018-06-21 22:22:59 -0700
/// Engine • revision 549c855e89
/// Tools • Dart 2.0.0-dev.61.0.flutter-c95617b19c
/// But is happening on Flutter v0.5.6-pre.51,
class RowMaterialBugB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(color: Colors.green, width: 100.0, height: 100.0,),
            Container(color: Colors.red, width: 100.0, height: 100.0,),
            Container(color: Colors.blue, width: 100.0, height: 100.0,),
          ],
        ),
        Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(color: Colors.green, width: 100.0, height: 100.0,),
            Container(color: Colors.red, width: 100.0, height: 100.0,),
            Container(color: Colors.blue, width: 100.0, height: 100.0,),
          ],
        ),
        Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(color: Colors.green, width: 100.0, height: 100.0,),

            // Causes all following widgets in this Row and in the parent Column to no longer render
            RaisedButton(onPressed: (){}),


            Container(color: Colors.red, width: 100.0, height: 100.0,),
            Container(color: Colors.blue, width: 100.0, height: 100.0,),
          ],
        ),
        Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(color: Colors.green, width: 100.0, height: 100.0,),
            Container(color: Colors.red, width: 100.0, height: 100.0,),
            Container(color: Colors.blue, width: 100.0, height: 100.0,),
          ],
        ),
        Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(color: Colors.green, width: 100.0, height: 100.0,),
            Container(color: Colors.red, width: 100.0, height: 100.0,),
            Container(color: Colors.blue, width: 100.0, height: 100.0,),
          ],
        ),
      ],
    );
  }
}


/// https://github.com/flutter/flutter/issues/14421
class BorderRadiusBug extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Center(
        child: new Container(
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(15.0),
              border: new Border.all(color: Colors.black)
          ),
          child: new Container(color: Colors.blue),
        ),
      ),
    );
  }
}

/// https://github.com/flutter/flutter/issues/17687 AND
/// https://github.com/flutter/flutter/issues/17686
class ToImageBug extends StatelessWidget {
  final GlobalKey repaintBoundary = new GlobalKey();

  void _saveToImage() async {
    RenderRepaintBoundary boundary = repaintBoundary.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 5.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    _showImage(pngBytes);
  }

  void _showImage(Uint8List imageBytes){
    showDialog(
      context: repaintBoundary.currentContext,
      barrierDismissible: true,
      builder: (BuildContext context2) =>
        new Center(
          child: new Container(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.green, width: 5.0),
              color: Colors.blue,
            ),
            child: new Image(image: new MemoryImage(imageBytes), fit: BoxFit.contain,)
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(".toImage() Bug Report Demo"),
        ),
        body: new RepaintBoundary(
          key: repaintBoundary,
          child: new Stack(
            children: <Widget>[
              new Positioned.fill(
                  child: new Center(
                      child: new Text("Something to have behind the image", textAlign: TextAlign.center)
                  )
              ),
              new Positioned.fill(
                  child: new Image.asset("images/unsplash.jpg", fit: BoxFit.cover)
              ),
              new Positioned.fill(
                  child: new Container(decoration: new BoxDecoration(border: new Border.all(color: Colors.red, width: 5.0)),)
              ),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _saveToImage,
          tooltip: 'Save as image',
          child: new Icon(Icons.camera),
        ),
      ),
    );
  }
}

