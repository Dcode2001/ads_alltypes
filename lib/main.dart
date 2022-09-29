import 'package:ads_alltypes/banner_ad.dart';
import 'package:ads_alltypes/inter_ad.dart';
import 'package:ads_alltypes/native_ad.dart';
import 'package:ads_alltypes/rewardad_ad.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app_open_ads_/app_lifecycle_reactor.dart';
import 'app_open_ads_/app_open_ad_manager.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();  // Inter & Reward Ad Mate AA 2 Lines Mukvi main.dart ma...
  MobileAds.instance.initialize();
  runApp(MaterialApp(home: MyApp(),));
}

const int maxFailedLoadAttempts = 3;



/*
void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}*/

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select ADS"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return banner_ad();
              },));
            }, child: Text("Banner Ad")),

            SizedBox(height: 10),

            ElevatedButton(onPressed: () {

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return inter_ad();
              },));
            }, child: Text("Inter Ad")),

            SizedBox(height: 10),

            ElevatedButton(onPressed: () {

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return rewardad_ads();
              },));
            }, child: Text("Reawardad Ad")),

            SizedBox(height: 10),
            ElevatedButton(onPressed: () {

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return native_ads();
              },));
            }, child: Text("Native Ad")),

          ],
        )),
      )),
    );
  }
}
