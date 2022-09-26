import 'package:ads_alltypes/banner_ad.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Ads"),
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

          ],
        )),
      )),
    );
  }
}
