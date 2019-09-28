import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zx_waifu/screens/collection.dart';
import 'package:zx_waifu/screens/find.dart';
import 'package:zx_waifu/screens/main.dart';
import 'package:zx_waifu/settings.dart';

// AppId ca-app-pub-6277008188307342~6490223324
// Banner ca-app-pub-6277008188307342/8299603797
// Interstitial ca-app-pub-6277008188307342/4608265635

const appId = "ca-app-pub-6277008188307342~6490223324";
const bannerUnitId = "ca-app-pub-6277008188307342/8299603797";
const interstitialUnitId = "ca-app-pub-6277008188307342/4608265635";

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  childDirected: false,
  testDevices: <String>[],
);

BannerAd myBanner = BannerAd(
  adUnitId: bannerUnitId,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  adUnitId: interstitialUnitId,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

Settings settings = Settings();
Random rand = Random();

void main() => runApp(SandBoxApp());


class SandBoxApp extends StatefulWidget {
  static int countViewed;
  @override
  _SandBoxAppState createState() => _SandBoxAppState();
}

class _SandBoxAppState extends State<SandBoxApp> {
  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: appId);
    super.initState();
    SandBoxApp.countViewed = 0;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZX Waifu',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue[300],
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 8.0, fontFamily: 'Hind'),
          button: TextStyle(fontSize: 20.0),
        ),        
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => ScreenMain(),
        '/find' : (context) => ScreenFind(),
        '/collection' : (context) => ScreenCollection(),
      },
      builder: (BuildContext context, Widget child) {
         myBanner
          ..load()
          ..show(
            anchorOffset: 0.0,
            anchorType: AnchorType.bottom,
          );
        return child;
      },
    );
  }
}