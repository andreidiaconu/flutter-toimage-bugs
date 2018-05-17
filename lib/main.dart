import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
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

