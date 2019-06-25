import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:firebase_admob/firebase_admob.dart';

import 'package:ads/ads.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  final String appId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544~3347511713'
      : 'ca-app-pub-3940256099942544~1458002511';

  final String bannerUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  @override
  void initState() {
    super.initState();

    /// Assign a listener.
    var eventListener = (MobileAdEvent event) {
      if (event == MobileAdEvent.clicked) {
        print("The opened ad is clicked on.");
      }
    };

    Ads.init(
      appId,
      bannerUnitId: bannerUnitId,
      keywords: <String>['ibm', 'computers'],
      contentUrl: 'http://www.ibm.com',
      childDirected: false,
      testDevices: ['Samsung_Galaxy_SII_API_26:5554'],
      testing: false,
      listener: eventListener,
    );

    Ads.showBannerAd();
  }

  @override
  void dispose() {
    Ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AdMob Banner Ad Example'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                    key: ValueKey<String>('SHOW BANNER'),
                    child: const Text('SHOW BANNER'),
                    onPressed: () {
                      Ads.showBannerAd(state: this, anchorOffset: null);
                    }),
                RaisedButton(
                    key: ValueKey<String>('REMOVE BANNER'),
                    child: const Text('REMOVE BANNER'),
                    onPressed: () {
                      Ads.hideBannerAd();
                    }),
              ].map((Widget button) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: button,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
