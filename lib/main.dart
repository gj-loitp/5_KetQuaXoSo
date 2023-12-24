import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/widget/splash/splash_screen.dart';

//TODO rate app
//TODO share app
//TODO more app
//TODO policy
//TODO ad
//TODO firebase
//TODO lich su ve so cua toi
//TODO do ve so manually
//TODO do ve so auto
//TODO scan de do ve so
//TODO https://pub.dev/packages/animated_introduction
//TODO https://pub.dev/packages/super_tooltip

//done
//ic_launcher
//pkg name
//ad id manifest
//splash screen

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    GetMaterialApp(
      enableLog: true,
      debugShowCheckedModeBanner: true,
      defaultTransition: Transition.cupertino,
      home: const MyApp(),
      navigatorKey: navigatorKey,
      theme: ThemeData.light(),
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
      title: 'Learn Flutter Step By Step',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
    );
  }
}
