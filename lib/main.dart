import 'package:flutter/material.dart';
import 'package:flutter_2020/routes/router.dart';

import 'pages/tabs/Tabs.dart';
import 'routes/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Tabs(),
      initialRoute: '/productList', // 使用路由对应页面
      onGenerateRoute: onGenerateRoute,
    );
  }
}
