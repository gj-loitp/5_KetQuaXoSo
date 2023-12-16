import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/widget/demo_login/demo_login_screen.dart';

//TODO splash screen
//TODO rate app
//TODO share app
//TODO more app
//TODO policy
//TODO ad
//TODO firebase

//done
//ic_launcher
//pkg name
//ad id manifest

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
        primarySwatch: Colors.deepOrange,
      ),
      home: const DemoLoginScreen(title: 'Learn Flutter Step By Step'),
    );
  }
}
