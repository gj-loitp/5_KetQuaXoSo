import 'dart:io';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';

import 'mckimquyen/common/const/color_constants.dart';
import 'mckimquyen/widget/applovin/applovin_screen.dart';
import 'mckimquyen/widget/main/controller_main.dart';
import 'mckimquyen/widget/splash/splash_screen.dart';

//TODO firebase

//TODO lich su ve so cua toi
//TODO notification reminder
//TODO scan de do ve so

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

//ref, documents
//https://baomoi.com/tien-ich/ket-qua-vietlott-mega645.epi
//https://xoso.mobi/tin-tuc/cach-chen-ma-code-nhung-ket-qua-truc-tiep-xo-so-dua-vao-website-blog-n7417.html#ma_code_nhung_ket_qua_xo_so_truc_tiep_cua_vietlott_theo_ngay

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  initializePlugin();
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
    debugPrint("roy93~ initializePlugin !success");
  } else {
    debugPrint("roy93~ initializePlugin success");
    if (kDebugMode) {
      Get.snackbar("Applovin", "initializePlugin success (only show this msg in debug mode)");
    }
  }
  ControllerMain controllerMain = Get.find();
  controllerMain.isInitializePluginApplovinFinished.value = true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerMain controllerMain = Get.put(ControllerMain());
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
