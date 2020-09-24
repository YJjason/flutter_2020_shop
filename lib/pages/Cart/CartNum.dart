/*
 * @Author: Jason_Ma
 * @Date: 2020-09-24 10:51:54
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 16:19:55
 * @FilePath: /flutter_2020_shop/lib/pages/Cart/CartNum.dart
 */
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import './../../provider/Cart.dart';
import 'package:flutter/widgets.dart';
import '../../services/ScreenAdapter.dart';

class CartNum extends StatefulWidget {
  CartNum({Key key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(164),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
      ),
      child: Row(
        children: <Widget>[_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }

  // 左侧按钮
  Widget _leftBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text('-'),
      ),
    );
  }

  // 中间内容
  Widget _centerArea() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(70),
      height: ScreenAdapter.height(45),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 1, color: Colors.black12),
          right: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: Text('1'),
    );
  }

  // 右侧按钮
  Widget _rightBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text("+"),
      ),
    );
  }
}
