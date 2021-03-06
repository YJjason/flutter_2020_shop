import 'package:flutter/material.dart';
import '../../config/config.dart';
import '../../widget/JdButton.dart';
import './../../services/CartServices.dart'; // 购物车数据
import './../../services/ScreenAdapter.dart';
import '../../model/ProductContentModel.dart';
// 底部弹出商品属性
// event_bus
import './../../services/EventBus.dart';
import 'package:provider/provider.dart';
import './../../provider/Cart.dart';

import './CartNum.dart';

class ProductContentFirst extends StatefulWidget {
  final List _productContentList;
  ProductContentFirst(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst>
    with AutomaticKeepAliveClientMixin {
  ProductContentitem _productContent;
  List _attr = [];
  String _selectedValue;
  bool get wantKeepAlive => true;

  var actionEventBus;
  var cartProvider;

  @override
  void initState() {
    this._productContent = widget._productContentList[0];

    this._attr = this._productContent.attr;

    _initAttr();
    // 监听所有广播
    this.actionEventBus = eventBus.on<ProductContentEvent>().listen((event) {
      print('enent ${event}');
      this._attrBottomSheet();
    });
  }

  //销毁
  void dispose() {
    super.dispose();
    this.actionEventBus.cancel(); //取消事件监听
  }

  // 初始化属性 格式化数据
  _initAttr() {
    var attr = this._attr;
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": true});
        } else {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": false});
        }
      }
    }
    _getSelectedAttrValue();
  }

  //获取选中的值
  _getSelectedAttrValue() {
    var _list = this._attr;
    List tempArr = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].attrList.length; j++) {
        if (_list[i].attrList[j]['checked'] == true) {
          tempArr.add(_list[i].attrList[j]['title']);
        }
      }
    }
    setState(() {
      this._selectedValue = tempArr.join(',');
      // 给选中属性赋值
      this._productContent.selectedAttr = this._selectedValue;
    });
  }

  // 改变属性值
  _changeAttr(cate, title, setBottomState) {
    var attr = this._attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].attrList.length; j++) {
          attr[i].attrList[j]["checked"] = false;
          if (title == attr[i].attrList[j]["title"]) {
            attr[i].attrList[j]["checked"] = true;
          }
        }
      }
    }
    setBottomState(() {
      //注意  改变showModalBottomSheet里面的数据 来源于StatefulBuilder
      this._attr = attr;
    });
    _getSelectedAttrValue();
  }

  //循环具体属性
  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    attrItem.attrList.forEach((item) {
      attrItemList.add(
        Container(
          margin: EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              _changeAttr(attrItem, item['title'], setBottomState);
            },
            child: Chip(
              label: Text("${item["title"]}"),
              padding: EdgeInsets.all(10),
              backgroundColor: item["checked"] ? Colors.red : Colors.black26,
            ),
          ),
        ),
      );
    });
    return attrItemList;
  }

  //封装一个组件 渲染attr
  List<Widget> _getAttrWidget(setBottomState) {
    List<Widget> attrList = [];
    this._attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(120),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(22)),
              child: Text("${attrItem.cate}: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            width: ScreenAdapter.width(590),
            child: Wrap(
              children: _getAttrItemWidget(attrItem, setBottomState),
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
        return StatefulBuilder(
          builder: (BuildContext context, setBottomState) {
            return GestureDetector(
              //Gesture:手势  Detector:探测器
              //解决showModalBottomSheet点击消失的问题
              onTap: () {
                return false;
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(ScreenAdapter.width(20)),
                    child: ListView(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _getAttrWidget(setBottomState),
                        ),
                        Divider(),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: ScreenAdapter.height(80),
                          child: InkWell(
                            onTap: () {
                              _attrBottomSheet();
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "数量",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10),
                                CartNum(this._productContent),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(76),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: JdButton(
                              color: Color.fromRGBO(253, 1, 0, 0.9),
                              text: "加入购物车",
                              cb: () async {
                                // print('加入购物车');
                                await CartServices.addCart(
                                    this._productContent);
                                //关闭底部筛选属性
                                Navigator.of(context).pop();
                                //调用Provider 更新数据
                                this.cartProvider.updateCartList();
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    this.cartProvider = Provider.of<Cart>(context);
    // 图片处理
    String pic = Config.domain + this._productContent.pic;
    pic = pic.replaceAll('\\', "/");
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 12,
            child: Image.network(
                // 'https://www.itying.com/images/flutter/p1.jpg',
                "${pic}",
                fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${this._productContent.title}',
              style: TextStyle(
                  color: Colors.black87, fontSize: ScreenAdapter.size(36)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${this._productContent.subTitle}',
              style: TextStyle(
                  color: Colors.black87, fontSize: ScreenAdapter.size(36)),
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
                          fontSize: ScreenAdapter.size(36),
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
                          fontSize: ScreenAdapter.size(28),
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
            height: ScreenAdapter.height(80),
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
                  Text("${this._selectedValue}")
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            height: ScreenAdapter.height(80),
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
