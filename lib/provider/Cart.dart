/*
 * @Author: Jason_Ma
 * @Date: 2020-09-24 10:15:19
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 11:39:53
 * @FilePath: /flutter_2020_shop/lib/provider/Cart.dart
 */
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List _cartList = []; // 状态

  int get cartNum => this._cartList.length;
  List get cartList => this._cartList;
  addData(value) {
    this._cartList.add(value);
    print('cartList -- ${this._cartList}');
    notifyListeners();
  }

  deleteData(value) {
    this._cartList.remove(value);
    notifyListeners();
  }
}
