/*
 * @Author: Jason_Ma
 * @Date: 2020-09-24 10:15:19
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-25 17:42:40
 * @FilePath: /flutter_2020_shop/lib/provider/Cart.dart
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import './../services/Storage.dart';

class Cart with ChangeNotifier {
  List _cartList = []; //状态
  bool _isCheckedAll = false; // 是否全选
  List get cartList => this._cartList;
  bool get isCheckedAll => this._isCheckedAll;
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
    //获取全选的状态
    this._isCheckedAll = this.isCheckAll();
    notifyListeners();
  }

  updateCartList() {
    this.init();
  }

  itemCountChange() {
    Storage.setString('cartList', this._cartList);
    notifyListeners();
  }

  //全选 反选
  checkAll(value) {
    for (var i = 0; i < this._cartList.length; i++) {
      this._cartList[i]['checked'] = value;
    }
    this._isCheckedAll = value;
    Storage.setString('cartList', json.encode(this._cartList));
    notifyListeners();
  }

  //判断是否全选
  bool isCheckAll() {
    if (this._cartList.length > 0) {
      for (var i = 0; i < this._cartList.length; i++) {
        if (this._cartList[i]['checked'] == false) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  //监听每一项的选中事件
  itemChage() {
    if (this.isCheckAll() == true) {
      this._isCheckedAll = true;
    } else {
      this._isCheckedAll = false;
    }
    Storage.setString('cartList', json.encode(this._cartList));
    notifyListeners();
  }
}
