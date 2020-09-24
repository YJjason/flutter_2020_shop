/*
 * @Author: Jason_Ma
 * @Date: 2020-09-24 10:38:14
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 16:42:01
 * @FilePath: /flutter_2020_shop/lib/pages/Cart/CartItem.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_2020/services/ScreenAdapter.dart';
// import 'package:provider/provider.dart';
// import './../../provider/Cart.dart';

import './CartNum.dart';
import './../../services/ScreenAdapter.dart';

class CartItem extends StatefulWidget {
  CartItem({Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
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
            width: ScreenAdapter.width(50),
            child: Checkbox(
              value: true,
              onChanged: (val) {},
              activeColor: Colors.pink,
            ),
          ),
          Container(
            width: ScreenAdapter.width(110),
            child: Image.network(
              "https://www.itying.com/images/flutter/list2.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '菲特旋转盖轻量杯不锈钢保温杯学生杯商务杯情侣杯保冷杯子便携水杯LHC4131WB(450Ml)白蓝',
                    maxLines: 2,
                  ),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "¥12",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(),
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
