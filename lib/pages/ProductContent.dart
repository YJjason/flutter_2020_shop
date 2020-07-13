import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './ProductContent/ProductContentFirst.dart';
import './ProductContent/ProductContentSecond.dart';
import './ProductContent/ProductContentThird.dart';
import './../widget/LoadingWidget.dart';

import './../config/config.dart';
// 按钮组件
import './../widget/JdButton.dart';
import './../model/ProductContentModel.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;
  ProductContentPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  List _productContentList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getContentData();
  }

  _getContentData() async {
    var api = "${Config.domain}api/pcontent?id=${widget.arguments['id']}";
    var result = await Dio().get(api);
    var productContent = ProductContentModel.fromJson(result.data);
    setState(() {
      this._productContentList.add(productContent.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(400),
                child: TabBar(
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: <Widget>[
                    Tab(
                      child: Text('商品'),
                    ),
                    Tab(
                      child: Text('详情'),
                    ),
                    Tab(
                      child: Text('评价'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                      ScreenUtil().setWidth(600), 76, 10, 0),
                  items: [
                    PopupMenuItem(
                      child: Row(
                        children: <Widget>[Icon(Icons.home), Text('首页')],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: <Widget>[Icon(Icons.home), Text('搜索')],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: this._productContentList.length > 0
            ? Stack(
                children: <Widget>[
                  TabBarView(
                    children: <Widget>[
                      ProductContentFirst(this._productContentList),
                      ProductContentSecond(),
                      ProductContentThird(),
                    ],
                  ),
                  Positioned(
                    width: ScreenUtil().setWidth(750),
                    height: ScreenUtil().setHeight(110),
                    bottom: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: Colors.black54,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(5),
                            ),
                            width: 100,
                            height: ScreenUtil().setHeight(80),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.shopping_cart,
                                  size: 20,
                                ),
                                Text('购物车')
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: JdButton(
                              color: Color.fromRGBO(253, 1, 0, 0.9),
                              text: '加入购物车',
                              cb: () {
                                print('加入购物车');
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: JdButton(
                              color: Color.fromRGBO(253, 1, 0, 0.9),
                              text: '立即购物',
                              cb: () {
                                print('立即购物');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : LoadingWidget(),
      ),
    );
  }
}
