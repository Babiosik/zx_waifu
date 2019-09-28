import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zx_waifu/main.dart';

class ScreenCollection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScreenCollectionState();
}

class ScreenCollectionState extends State<ScreenCollection> {

  static List<MyCollectionImageState> states;

  @override
  Widget build(BuildContext context) {
    int lastIndex = 0;
    if (states == null) {
      states = new List<MyCollectionImageState> ();
    }
    if (settings.liked.length == 0) {
      return Scaffold(
        appBar: AppBar (title: Text('ZX Waifu / Collection')),
        backgroundColor: Colors.blue[300],
        body: Align(
          alignment: Alignment.center,
          child: Text("Sorry, but you don't like anything", style: TextStyle(fontSize: 20)),
        )
      );
    } else {
      return Scaffold(
        appBar: AppBar (title: Text('ZX Waifu / Collection')),
        backgroundColor: Colors.blue[300],
        body: Container(
          padding: EdgeInsets.only(bottom: 60),
          child: ListView.builder(
            itemCount: (settings.liked.length / 2).ceil(),
            itemBuilder: (context, index) {
              int oddIndex = lastIndex++, evenIndex = lastIndex++;
              Widget odd = MyCollectionImage(idImage: settings.liked[oddIndex], parent: this,);
              Widget even = (evenIndex < settings.liked.length ? MyCollectionImage(idImage: settings.liked[evenIndex], parent: this,) : Container());
              return Container(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[ odd, even ],
                ),
              );
            },
          ),
        ),
      );
    }
    
  }
  
  @override
	void dispose(){
    states = null;
		super.dispose();
	}

  void refresh () {
    states.forEach((e) {
      if (e.choised)
        e.setState(() {
          e.choised = false;
        });
    });
    setState(() { });
  }

}

class MyCollectionImage extends StatefulWidget {

  final String idImage;
  final ScreenCollectionState parent;

  const MyCollectionImage({Key key, this.idImage, this.parent}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyCollectionImageState();

}

class MyCollectionImageState extends State<MyCollectionImage> {

  bool choised = false;

  @override
  Widget build(BuildContext context) {
    if (ScreenCollectionState.states.indexOf(this) == -1) {
      ScreenCollectionState.states.add(this);
    }
    Widget child;
    if (choised) {
      child = Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 4),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(26.0),
              child: Stack(
                children: <Widget>[
                  Image.network("https://www.thiswaifudoesnotexist.net/example-${widget.idImage}.jpg"),
                  Positioned(
                    top: 10,
                    bottom: 150,
                    left: 30,
                    right: 100,
                    child:
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        color: Colors.black.withOpacity(0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () { setState(() { choised = false; }); },
                    icon: Icon(Icons.cancel, size: 50,),
                    iconSize: 50,
                  ),
                  IconButton(
                    onPressed: () {
                      settings.liked.remove(widget.idImage);
                      widget.parent.refresh();
                    },
                    icon: Icon(Icons.delete, size: 50,),
                    iconSize: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      child = FlatButton(
        onPressed: () { choise(); },
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(30.0),
          child: Image.network("https://www.thiswaifudoesnotexist.net/example-${widget.idImage}.jpg"),
        ),
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.all(5),
      child: child
    );
  }

  void choise () {
    ScreenCollectionState.states.forEach((e) {
      if (e.choised)
        e.setState(() {
          e.choised = false;
        });
    });
    setState(() {
      choised = true;
    });
  }

}