/*
 * @Author: Jason_Ma
 * @Date: 2020-09-24 10:38:14
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-25 17:45:55
 * @FilePath: /flutter_2020_shop/lib/pages/Cart/CartItem.dart
 */
import 'package:flutter/material.dart';
import './CartNum.dart';
import './../../services/ScreenAdapter.dart';
import './../tabs/Cart.dart';
import 'package:provider/provider.dart';
import './../../provider/Cart.dart';

class CartItem extends StatefulWidget {
  Map _itemData;
  CartItem(this._itemData, {Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map _itemData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._itemData = widget._itemData;
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Container(
      height: ScreenAdapter.height(200),
      padding: EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(60),
            child: Checkbox(
              value: _itemData['checked'],
              onChanged: (val) {
                _itemData['checked'] = !_itemData['checked'];
                cartProvider.itemChage();
              },
              activeColor: Colors.pink,
            ),
          ),
          Container(
            width: ScreenAdapter.width(160),
            child: Image.network(
              // "https://www.itying.com/images/flutter/list2.jpg",
              "${_itemData["pic"]}",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      // '菲特旋转盖轻量杯不锈钢保温杯学生杯商务杯情侣杯保冷杯子便携水杯LHC4131WB(450Ml)白蓝',
                      "${_itemData["title"]}",
                      maxLines: 2),
                  Text("${_itemData["selectedAttr"]}", maxLines: 2),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          // "¥12",
                          "${_itemData["price"]}",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(_itemData),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
