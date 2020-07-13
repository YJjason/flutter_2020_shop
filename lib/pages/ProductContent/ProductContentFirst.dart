import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_2020/config/config.dart';
import 'package:flutter_2020/widget/JdButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import "./../../model/ProductContentModel.dart";
// 底部弹出商品属性

class ProductContentFirst extends StatefulWidget {
  final List _productContentFirst;
  ProductContentFirst(this._productContentFirst, {Key key}) : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> {
  ProductContentitem _productContent;
  List _attr = [];
  @override
  void initState() {
    super.initState();
    this._productContent = widget._productContentFirst[0];
    this._attr = this._productContent.attr;
    //[{"cate":"鞋面材料","list":["牛皮 "]},{"cate":"闭合方式","list":["系带"]},{"cate":"颜色","list":["红色","白色","黄色"]}]
  }

  List<Widget> _getAttrItemWidget(attrItem) {
    List<Widget> attrItemList = [];
    attrItem.list.forEach((item) {
      attrItemList.add(
        Container(
          margin: EdgeInsets.all(10),
          child: Chip(
            label: Text("${item}"),
            padding: EdgeInsets.all(10),
          ),
        ),
      );
    });
    return attrItemList;
  }

  //封装一个组件 渲染attr
  /*  List<Widget> _getAttrWidget() {
    List<Widget> attrList = [];
    this._attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(120),
            child: Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(20),
              ),
              child: Text(
                "${attrItem.cate}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(590),
            child: Wrap(
              children: _getAttrItemWidget(attrItem),
            ),
          )
        ],
      ));
    });
    return attrList;
  } */
  List<Widget> _getAttrWidget() {
    List<Widget> attrList = [];
    this._attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(120),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(22)),
              child: Text("${attrItem.cate}: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(590),
            child: Wrap(
              children: _getAttrItemWidget(attrItem),
            ),
          )
        ],
      ));
    });

    return attrList;
  }

  //底部弹出框
  _attrBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GestureDetector(
          //Gesture:手势  Detector:探测器
          //解决showModalBottomSheet点击消失的问题
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getAttrWidget(),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                width: ScreenUtil().setWidth(750),
                height: ScreenUtil().setHeight(76),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                            color: Color.fromRGBO(255, 165, 0, 0.9),
                            text: "立即购买",
                            cb: () {
                              print('立即购买');
                            },
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 图片处理
    String pic = Config.domain + this._productContent.pic;
    pic = pic.replaceAll('\\', "/");
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              // 'https://www.itying.com/images/flutter/p1.jpg',
              "${pic}",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${this._productContent.title}',
              style: TextStyle(
                  color: Colors.black87, fontSize: ScreenUtil().setSp(36)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${this._productContent.subTitle}',
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
                        '¥${this._productContent.price}',
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
                        '¥${this._productContent.oldPrice}',
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
