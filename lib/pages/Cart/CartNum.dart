/*
 * @Author: Jason_Ma
 * @Date: 2020-09-24 10:51:54
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 11:43:42
 * @FilePath: /flutter_2020_shop/lib/pages/Cart/CartNum.dart
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../../provider/Cart.dart';

class CartNum extends StatefulWidget {
  CartNum({Key key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    print('cartProvider,--- ${cartProvider}');
    return Column(
      children: <Widget>[
        Text("${cartProvider.cartNum}"),
      ],
    );
  }
}
