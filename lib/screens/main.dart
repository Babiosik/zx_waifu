import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String credits = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nCredits\nAll images were created\nby a neural network\nand taken from the site\nhttps://www.thiswaifudoesnotexist.net";

    return Scaffold(
      appBar: AppBar (title: Text('ZX Waifu')),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyButtonMainMenu(
              onPressed: () { Navigator.pushNamed(context, '/find'); },
              text: "Find waifu",
            ),
            MyButtonMainMenu(
              onPressed: () { Navigator.pushNamed(context, '/collection'); },
              text: "My collection",
            ),
            MyButtonMainMenu(
              onPressed: () { exit(0); },
              text: "Exit",
            ),
            Text(credits, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
  
}

class MyButtonMainMenu extends StatelessWidget {

  final Function onPressed;
  final String text;

  const MyButtonMainMenu({Key key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text(text),
      color: Colors.blue[300],
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 1.0), borderRadius: new BorderRadius.circular(30.0)),
      padding: EdgeInsets.symmetric(horizontal: 40),
    );
  }


}