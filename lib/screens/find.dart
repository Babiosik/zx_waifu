import 'package:firebase_admob/firebase_admob.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zx_waifu/main.dart';

class ScreenFind extends StatefulWidget {
  @override
  _ScreenFindState createState() => _ScreenFindState();
}

class _ScreenFindState extends State<ScreenFind> {
  @override
  Widget build(BuildContext context) {
    if (settings.lastId == null || settings.lastId == "") {
      settings.nextId();
    }
    return Scaffold(
      appBar: AppBar (title: Text('ZX Waifu / Find')),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width,
              child: Image.network("https://www.thiswaifudoesnotexist.net/example-${settings.lastId}.jpg")
            ),
            Controlls(newImage: newImage,),
          ],
        ),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
  void newImage (bool isLike) async {
    http.get('http://apigames.kl.com.ua/zx_waifu.php?id=${settings.lastId}&set=$isLike');
    print(SandBoxApp.countViewed);
    if (++SandBoxApp.countViewed > 19) {
      myInterstitial..load()..show(anchorType: AnchorType.bottom);
      SandBoxApp.countViewed = 0;
    }
    setState(() {
      if (isLike) {
        settings.liked.add(settings.lastId);
      }
      settings.nextId(); 
    });
  }
}

class Controlls extends StatelessWidget {

  final Function newImage;

  const Controlls({Key key, this.newImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(5),
                child: new RawMaterialButton(
                  onPressed: () { newImage(false); },
                  child: new Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: new Icon(
                      Icons.close,
                      size: 60.0,
                      color: Colors.black,
                    ),
                  ),
                  shape: new CircleBorder(),
                  fillColor: Colors.white,
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(5),
                child: new RawMaterialButton(
                  onPressed: () { newImage(true); },
                  child: new Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: new Icon(
                      Icons.favorite_border,
                      size: 60.0,
                      color: Colors.black,
                    ),
                  ),
                  shape: new CircleBorder(),
                  fillColor: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
