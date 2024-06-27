import 'package:flutter/material.dart';

class TabSoccer extends StatelessWidget {
  const TabSoccer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          // center the children
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.favorite,
              size: 160.0,
              color: Colors.white,
            ),
            Text(
              "Tab1",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
