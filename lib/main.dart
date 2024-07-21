import 'dart:io';

import 'package:applovin_max/applovin_max.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';

import 'mckimquyen/common/const/color_constants.dart';
import 'mckimquyen/widget/applovin/applovin_screen.dart';
import 'mckimquyen/widget/main/controller_main.dart';
import 'mckimquyen/widget/splash/splash_screen.dart';

//TODO multi language
//TODO quan ly ve so
//TODO scan de do ve so
//TODO https://pub.dev/packages/slide_countdown -> thoi gian cho den quay so
//TODO lich van nien https://baomoi.com/tien-ich/lich-van-nien.epi
//TODO du bao thoi tiet https://baomoi.com/tien-ich/thoi-tiet.epi
//TODO gia vang https://baomoi.com/tien-ich/gia-vang.epi
//TODO kqxs bao moi https://baomoi.com/tien-ich/ket-qua-xo-so.epi
//TODO rss feed https://elfsight.com/rss-feed-widget/html/
//TODO widget weather https://elfsight.com/weather-widget/html/
//TODO corona https://elfsight.com/coronavirus-stats-widget/html/
//TODO rss 24h https://bongda24h.vn/RSS.html

//done mckimquyen
//ic_launcher
//pkg name
//ad id manifest
//splash screen
//rate app
//share app
//more app
//policy
//do ve so manually
//do ve so auto
//chuyen xsmn, xsmt, xsmb cac button lich su -> profile
//today show 1 cai toast
//nut lich su se thanh nut list province
//double to exit
//keystore mckimquyen
//them version infor o cac man hinh can thiet
//add hero efx
//https://pub.dev/packages/animated_introduction
//ad applovin
//20 tester
//notification reminder
//fb analytics https://console.firebase.google.com/u/0/project/com-mckimquyen-kqxs/crashlytics/app/android:com.mckimquyen.kqxs/issues
//firebase

//ref, documents
//https://baomoi.com/tien-ich/ket-qua-vietlott-mega645.epi
//https://xoso.mobi/tin-tuc/cach-chen-ma-code-nhung-ket-qua-truc-tiep-xo-so-dua-vao-website-blog-n7417.html#ma_code_nhung_ket_qua_xo_so_truc_tiep_cua_vietlott_theo_ngay

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  await initializePlugin();
  runApp(
    GetMaterialApp(
      enableLog: true,
      debugShowCheckedModeBanner: true,
      // defaultTransition: Transition.noTransition,
      defaultTransition: Transition.cupertino,
      // defaultTransition: Transition.circularReveal,
      // defaultTransition: Transition.size,
      // transitionDuration: const Duration(milliseconds: 1000),
      transitionDuration: const Duration(milliseconds: 700),
      home: const MyApp(),
      navigatorKey: navigatorKey,
      theme: ThemeData.light().copyWith(
        primaryColor: ColorConstants.appColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        splashColor: ColorConstants.appColor,
        highlightColor: ColorConstants.white,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
    ),
  );
}

Future<void> initializePlugin() async {
  deviceId = await FlutterUdid.consistentUdid;
  var configuration = await AppLovinMAX.initialize(sdkKey);
  if (configuration == null) {
    debugPrint("initializePlugin !success");
  } else {
    debugPrint("initializePlugin success");
  }
  final ControllerMain controllerMain = Get.put(ControllerMain());
  controllerMain.isInitializePluginApplovinFinished.value = true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerMain controllerMain = Get.find();
    controllerMain.timeStartApp.value = DateTime.now().millisecondsSinceEpoch;
    return MaterialApp(
      title: 'KQXS',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
