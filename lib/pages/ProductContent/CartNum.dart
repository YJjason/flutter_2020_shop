/*
 * @Author: Jason_Ma
 * @Date: 2020-09-25 09:14:29
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-25 09:38:20
 * @FilePath: /flutter_2020_shop/lib/pages/ProductContent/CartNum.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../services/ScreenAdapter.dart';
import '../../model/ProductContentModel.dart';

class CartNum extends StatefulWidget {
  ProductContentitem _productContent;
  CartNum(this._productContent, {Key key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  ProductContentitem _productContent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._productContent = widget._productContent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(164),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Row(
        children: <Widget>[_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }

  //左侧按钮
  Widget _leftBtn() {
    return InkWell(
      onTap: () {
        if (this._productContent.count > 1) {
          setState(() {
            this._productContent.count = this._productContent.count - 1;
          });
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

  //右侧按钮
  Widget _rightBtn() {
    return InkWell(
      onTap: () {
        setState(() {
          this._productContent.count = this._productContent.count + 1;
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text('+'),
      ),
    );
  }

  //中间区域
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
      child: Text('${this._productContent.count}'),
    );
  }
}
