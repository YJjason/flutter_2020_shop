// 商品列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './../config/config.dart';
import 'package:dio/dio.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;
  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
//通过事件打开侧边栏，需要全局声明一下：
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //筛选导航：
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(750),
      child: Container(
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(750),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color.fromRGBO(233, 233, 233, 0.9),
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(20), 0,
                      ScreenUtil().setHeight(20)),
                  child: Text(
                    '综合',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(20), 0,
                      ScreenUtil().setHeight(20)),
                  child: Text('销量', textAlign: TextAlign.center),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(20), 0,
                      ScreenUtil().setHeight(20)),
                  child: Text('价格', textAlign: TextAlign.center),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(20), 0,
                      ScreenUtil().setHeight(20)),
                  child: Text('筛选', textAlign: TextAlign.center),
                ),
                onTap: () {
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 商品列表
  Widget _productListWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(80)),
      child: ListView.builder(
        // itemCount: 2,
        itemBuilder: (context, index) {
          //获得每一个元素：
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(180),
                    height: ScreenUtil().setHeight(180),
                    child: Image.network(
                      "https://www.itying.com/images/flutter/list2.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: ScreenUtil().setHeight(180),
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'erwrwerwe',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: ScreenUtil().setHeight(36),
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                //注意：如果Container里面加上decoration属性，这个时候color属性必须放到BoxDecoration
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text('4g'),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(36),
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                //注意：如果Container里面加上decoration属性，这个时候color属性必须放到BoxDecoration
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color:Color.fromRGBO(230, 230, 230, 0.3)
                                ),
                                child: Text('16G'),
                              ),
                            ],
                          ),
                          Text('￥2999', style: TextStyle(color: Colors.red))
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                height: 20,
              )
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品列表'),
      ),
      body: Stack(
        children: <Widget>[
          _subHeaderWidget(),
          _productListWidget(),
        ],
      ),
    );
  }
}
