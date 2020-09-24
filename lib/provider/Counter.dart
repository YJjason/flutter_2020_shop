/*
 * @Author: Jason_Ma
 * @Date: 2020-09-24 10:20:33
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 11:33:31
 * @FilePath: /flutter_2020_shop/lib/provider/Counter.dart
 */
import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 1;
  Counter() {
    this._count = 10;
  }
  int get count => _count;
  incrementCount() {
    print('count ++');
    this._count++;
    notifyListeners();
  }
}
