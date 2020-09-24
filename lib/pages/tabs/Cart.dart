/*
 * @Author: Jason_Ma
 * @Date: 2020-07-13 10:16:40
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 11:13:01
 * @FilePath: /flutter_2020_shop/lib/pages/tabs/Cart.dart
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../provider/Cart.dart';
import './../../provider/Counter.dart';
import './../Cart/CartItem.dart';
import './../Cart/CartNum.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var counterProvider = Provider.of<Counter>(context);
    var cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.incrementCount();
          //给购物车列表增加数据
          cartProvider.addData('haha~${counterProvider.count}');
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text(
              '统计数量：${counterProvider.count}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Divider(),
          //加载购物车列表的子组件
          CartItem(),
          Divider(height: 40),
          CartNum(),
        ],
      ),
    );
  }
}
