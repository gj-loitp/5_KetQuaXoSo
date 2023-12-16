import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ketquaxoso/lib/core/base_stateful_state.dart';

import 'controller.dart';
import 'demo_login/demo_login_screen.dart';
import 'home_page_1.dart';
import 'lib/util/ui_utils.dart';
import 'lib/util/url_launcher_utils.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseStatefulState<MyHomePage> {
  // int count = 1;
  // String name = "Toi la button";

  final controller = Get.put(Controller());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.clearOnDispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "widget.title",
        () {
          SystemNavigator.pop();
        },
        () {
          UrlLauncherUtils.launchPolicy();
        },
        iconData: Icons.policy,
      ),
      body: Obx(() {
        return _buildBody();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // setState(() {
          //   count++;
          //   name = "Hello world";
          // });
          controller.setCount();
          controller.setName();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            "${controller.count.value}",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextButton(
            onPressed: () {
              showSnackBarFull("title", "message");
            },
            child: Text(controller.name.value),
          ),
          Image.network(
              "https://kenh14cdn.com/thumb_w/620/203336854389633024/2022/11/6/photo-9-1667711144754229839920.png"),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: Text("2"),
                ),
                Text("3"),
                Text("4"),
                Text("5"),
                Text("6"),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: Text("2"),
                ),
                Text("7"),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: Text("2"),
                ),
                Text("8"),
                Text("9"),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: Text("2"),
                ),
                Text("10"),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: Text("2"),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Get.to(const MyHomePage1(title: "Hellllllooo"));
            },
            child: const Text("next screen"),
          ),
          TextButton(
            onPressed: () {
              Get.to(const DemoLoginScreen());
            },
            child: const Text("Demo login screen"),
          ),
        ],
      ),
    );
  }
}
