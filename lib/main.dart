import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/common/const/color_constants.dart';
import 'package:ketquaxoso/lib/widget/splash/splash_screen.dart';

//TODO ad
//TODO firebase
//TODO lich su ve so cua toi

//TODO notification reminder
//TODO scan de do ve so
//TODO https://pub.dev/packages/animated_introduction
//TODO https://pub.dev/packages/super_tooltip
//TODO keystore mckimquyen
//TODO them vs infor o cac man hinh can thiet

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

//ref, documents
//https://baomoi.com/tien-ich/ket-qua-vietlott-mega645.epi
//https://xoso.mobi/tin-tuc/cach-chen-ma-code-nhung-ket-qua-truc-tiep-xo-so-dua-vao-website-blog-n7417.html#ma_code_nhung_ket_qua_xo_so_truc_tiep_cua_vietlott_theo_ngay

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    GetMaterialApp(
      enableLog: true,
      debugShowCheckedModeBanner: true,
      // defaultTransition: Transition.cupertino,
      defaultTransition: Transition.circularReveal,
      // defaultTransition: Transition.size,
      transitionDuration: const Duration(milliseconds: 1000),
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
