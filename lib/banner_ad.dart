import 'dart:io';

import 'package:ads_alltypes/main.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class banner_ad extends StatefulWidget {
  const banner_ad({Key? key}) : super(key: key);

  @override
  State<banner_ad> createState() => _banner_adState();
}

class _banner_adState extends State<banner_ad> {

  BannerAd? _bannerAd;
  bool _bannerAdIsLoaded = false;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(title: Text("Banner Ads"),centerTitle: true,),

      body: _bannerAdIsLoaded ?  Center(
        child: Container(
            height: _bannerAd!.size.height.toDouble(),
            width: _bannerAd!.size.width.toDouble(),
            child: AdWidget(ad: _bannerAd!)),
      )  :  Container(),
    ), onWillPop: goback);
  }

  Future<bool> goback()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MyApp();
    },));
    return Future.value();
  }

  //  pub.dev>>admob flutter>>github >> Example>>lib>>bannercodecopy...

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Create the ad objects and load ads.
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/6300978111'
            : 'ca-app-pub-3940256099942544/2934735716',
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            print('$BannerAd loaded.');
            setState(() {
              _bannerAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('$BannerAd failedToLoad: $error');
            ad.dispose();
          },
          onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        ),
        request: AdRequest())
      ..load();


    @override
    void dispose() {
      super.dispose();
      _bannerAd?.dispose();
    }
  }
  }




