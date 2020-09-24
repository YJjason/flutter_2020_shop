/*
 * @Author: Jason_Ma
 * @Date: 2020-09-23 16:37:57
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 10:29:56
 * @FilePath: /flutter_2020_shop/lib/main.dart
 */
import 'package:flutter/material.dart';
// 路由管理
import './routes/router.dart';
import 'pages/tabs/Tabs.dart';

// 引入provider 状态管理
import 'package:provider/provider.dart';
import './provider/Cart.dart';
import './provider/Counter.dart';

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
    // 使用状态管理
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Counter()),
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Tabs(),
        initialRoute: '/', // 初始路由
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(primaryColor: Colors.pink[100]), //修改主题
      ),
    );
    /*  return MaterialApp(
      // 关闭右上角debug 模式
      debugShowCheckedModeBanner: false,
      // home: Tabs(),
      initialRoute: '/', // 使用路由对应页面
      onGenerateRoute: onGenerateRoute,
      // 修改主题
      theme: ThemeData(primaryColor: Colors.pink[100]),
    ); */
  }
}
