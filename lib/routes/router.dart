/*
 * @Author: Jason_Ma
 * @Date: 2020-07-13 10:16:40
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 17:19:24
 * @FilePath: /flutter_2020_shop/lib/routes/router.dart
 */
import 'package:flutter/material.dart';
import './../pages/tabs/Tabs.dart';
import './../pages/Search.dart';

import './../pages/ProductList.dart';
import './../pages/ProductContent.dart';

//配置路由的地方：
final routes = {
  '/': (context) => Tabs(),
  '/search': (context) => SearchPage(),
  '/productList': (context, {arguments}) =>
      ProductListPage(arguments: arguments),
  // 商品中心
  '/productContent': (context, {arguments}) =>
      ProductContentPage(arguments: arguments),
};

// 路由传参 固定写法
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments),
      );
      return route;
    } else {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context),
      );
      return route;
    }
  }
};
