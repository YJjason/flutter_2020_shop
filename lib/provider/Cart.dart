/*
 * @Author: Jason_Ma
 * @Date: 2020-09-24 10:15:19
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-25 11:03:35
 * @FilePath: /flutter_2020_shop/lib/provider/Cart.dart
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import './../services/Storage.dart';

class Cart with ChangeNotifier {
  List _cartList = []; //状态
  List get cartList => this._cartList;
  Cart() {
    this.init();
  }
//初始化的时候获取购物车数据
  init() async {
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      this._cartList = cartListData;
    } catch (e) {
      this._cartList = [];
    }
    notifyListeners();
  }

  updateCartList() {
    this.init();
  }
/* 
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
  } */
}
