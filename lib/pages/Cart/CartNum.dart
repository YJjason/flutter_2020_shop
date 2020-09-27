/*
 * @Author: Jason_Ma
 * @Date: 2020-09-24 10:51:54
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-27 16:17:03
 * @FilePath: /flutter_2020_shop/lib/pages/Cart/CartNum.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import './../../provider/Cart.dart';

class CartNum extends StatefulWidget {
  Map _itemData;
  CartNum(this._itemData, {Key key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  Map _itemData;
  var cartProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._itemData = widget._itemData;
  }

  @override
  Widget build(BuildContext context) {
    this.cartProvider = Provider.of<Cart>(context);
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
      onTap: () {
        if (_itemData['count'] > 1) {
          _itemData['count']--;
          this.cartProvider.itemCountChange();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text('-'),
      ),
    );
  }

  // 右侧按钮
  Widget _rightBtn() {
    return InkWell(
      onTap: () {
        _itemData['count']++;
        this.cartProvider.itemCountChange();
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text("+"),
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
      child: Text("${_itemData["count"]}"),
    );
  }
}
