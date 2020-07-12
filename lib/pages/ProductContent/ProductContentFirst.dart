import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_2020/widget/JdButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 底部弹出商品属性

class ProductContentFirst extends StatefulWidget {
  ProductContentFirst({Key key}) : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> {
  _attrBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GestureDetector(
          //Gesture:手势  Detector:探测器
          onTap: () {
            return false;
          },
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Container(
                              width: ScreenUtil().setWidth(100),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(35),
                                ),
                                child: Text(
                                  '颜色',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              width: ScreenUtil().setWidth(610),
                              child: Wrap(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text('白色'),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text('白色'),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text('白色'),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                width: ScreenUtil().setWidth(750),
                height: ScreenUtil().setHeight(75),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(750),
                      height: ScreenUtil().setHeight(75),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: JdButton(
                                color: Color.fromRGBO(253, 1, 0, 0.9),
                                text: "加入购物车",
                                cb: () {
                                  print('加入购物车');
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: JdButton(
                                color: Color.fromRGBO(253, 1, 0, 0.9),
                                text: "立即购物",
                                cb: () {
                                  print('立即购物');
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              'https://www.itying.com/images/flutter/p1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'wrerafsdfsfafdssfdfsdfdsfsdf',
              style: TextStyle(
                  color: Colors.black87, fontSize: ScreenUtil().setSp(36)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'wrerafsdfsfafdssfdfsdfdsfsdf',
              style: TextStyle(
                  color: Colors.black87, fontSize: ScreenUtil().setSp(36)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text('特价'),
                      Text(
                        '¥23',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: ScreenUtil().setSp(36),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text('原价'),
                      Text(
                        '¥100',
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: ScreenUtil().setSp(28),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 筛选
          Container(
            margin: EdgeInsets.only(top: 10),
            height: ScreenUtil().setHeight(80),
            child: InkWell(
              onTap: () {
                _attrBottomSheet();
              },
              child: Row(
                children: <Widget>[
                  Text(
                    '已选',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('115,黑色')
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            height: ScreenUtil().setHeight(80),
            child: Row(
              children: <Widget>[
                Text(
                  '运费',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('免运费')
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
