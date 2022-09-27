import 'dart:io';

import 'package:ads_alltypes/app_open_ads_/app_lifecycle_reactor.dart';
import 'package:ads_alltypes/app_open_ads_/app_open_ad_manager.dart';
import 'package:ads_alltypes/banner_ad.dart';
import 'package:ads_alltypes/native_ad.dart';
import 'package:ads_alltypes/rewardad_ad.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'main.dart';

class inter_ad extends StatefulWidget {
  const inter_ad({Key? key}) : super(key: key);

  @override
  State<inter_ad> createState() => _inter_adState();
}

class _inter_adState extends State<inter_ad> {

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  int inter = 0;

  late AppLifecycleReactor _appLifecycleReactor;

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  @override
  void initState() {
    super.initState();

    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();  // ************
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();


    _createInterstitialAd();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {

      if(inter==1) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return banner_ad();
          },
        ));
      }
      else if(inter==2)
      {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return native_ads();
          },
        ));
      }
      else if(inter==3)
      {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return rewardad_ads();
          },
        ));
      }

      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();

        if(inter==1) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return banner_ad();
            },
          ));
        }
        else if(inter==2)
        {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return native_ads();
            },
          ));
        }
        else if(inter==3)
        {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return rewardad_ads();
            },
          ));
        }

        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        title: Text("Interstitial Ads"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  _showInterstitialAd();
                },
                child: Text("Click For InterstitialAd "))
          ],
        ),
      ),
    ), onWillPop:goback);
  }
  Future<bool> goback()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MyApp();
    },));
    return Future.value();
  }
}
