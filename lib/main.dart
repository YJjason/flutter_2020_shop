import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_2020/routes/router.dart';

import 'pages/tabs/Tabs.dart';
import 'routes/router.dart';

import './pages/Search.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      // 关闭右上角debug 模式
      debugShowCheckedModeBanner: false,
      // home: Tabs(),
      initialRoute: '/', // 使用路由对应页面
      onGenerateRoute: onGenerateRoute,
      // 修改主题
      theme: ThemeData(primaryColor: Colors.pink[100]),
    );
  }
}
