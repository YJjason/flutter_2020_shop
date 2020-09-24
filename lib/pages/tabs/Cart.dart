/*
 * @Author: Jason_Ma
 * @Date: 2020-07-13 10:16:40
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 16:42:32
 * @FilePath: /flutter_2020_shop/lib/pages/tabs/Cart.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './../../services/ScreenAdapter.dart';
// import 'package:provider/provider.dart';
// import './../../provider/Cart.dart';
// import './../../provider/Counter.dart';
import './../Cart/CartItem.dart';
// import './../Cart/CartNum.dart';

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
    ScreenAdapter.init(context);
    // var counterProvider = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.launch), onPressed: null)
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              CartItem(),
              CartItem(),
              CartItem(),
            ],
          ),
          Positioned(
            bottom: 0,
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(78),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Colors.black12),
                ),
                color: Colors.white,
              ),
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(78),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: ScreenAdapter.width(60),
                          child: Checkbox(
                            value: false,
                            onChanged: (val) {},
                            activeColor: Colors.pink,
                          ),
                        ),
                        Text('全选')
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      child: Text(
                        '结算',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.red,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
