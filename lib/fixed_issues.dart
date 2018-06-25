import 'package:flutter/material.dart';

/// issue: https://github.com/flutter/flutter/issues/18713
/// This is now fixed
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
/// This is now fixed
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