/*
 * @Author: Jason_Ma
 * @Date: 2020-09-24 10:38:14
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 10:51:05
 * @FilePath: /flutter_2020_shop/lib/pages/Cart/CartItem.dart
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../provider/Cart.dart';

class CartItem extends StatefulWidget {
  CartItem({Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    var cartProcider = Provider.of<Cart>(context);
    return cartProcider.cartList.length > 0
        ? Column(
            children: cartProcider.cartList.map((value) {
              return ListTile(
                title: Text("${value}"),
                trailing: InkWell(
                  onTap: () {
                    // 删除
                    cartProcider.deleteData(value);
                  },
                  child: Icon(Icons.delete),
                ),
              );
            }).toList(),
          )
        : Text('haha');
  }
}
