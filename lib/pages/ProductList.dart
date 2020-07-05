// 商品列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './../config/config.dart';
import 'package:dio/dio.dart';

import './../model/ProductModel.dart';
import '../widget/LoadingWidget.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;
  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
//通过事件打开侧边栏，需要全局声明一下：
// Scaffold的State对象
// 通常用来控制SnackBars和BottomSheets和Drawer的显示与隐藏.
// 基本用法
// 通过为Scaffold定义key属性, 声明_scaffoldState, 通过_scaffoldState直接调用scaffoldState方法
// 当组件无法直接为Scaffold定义key属性时, 可以通过 Context与Scaffold.of获取父级scaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //配置下拉加载更多：
  ScrollController _scrollController = new ScrollController();
  // 分页
  int _page = 1;
  // 每页显示数据
  int _pageSize = 10;
  // 当前分页数据
  List _productList = [];
  // 排序
  String _sort = '';
  // 解决重复请求的问题：
  bool flag = true;
// 是否有数据
  bool _hasMore = true;
  @override
  void initState() {
    super.initState();
    // 获取商品数据
    _getProductListData();
  }

  _getProductListData() async {
    setState(() {
      this.flag = false;
    });
    var api =
        '${Config.domain}api/plist?cid=${widget.arguments["cid"]}&page=${_page}&sort=${this._sort}&pageSize=${_pageSize}';
    print('api------${api}');
    var result = await Dio().get(api);
    var productList = ProductModel.fromJson(result.data);
    if (productList.result.length < this._pageSize) {
      setState(() {
        this._productList.addAll(productList.result);
        this._hasMore = false;
        this.flag = true;
      });
    } else {
      setState(() {
        this._productList.addAll(productList.result);
        this._page++;
        this.flag = true;
      });
    }
  }

//显示加载中的圈圈：
  Widget _showMor(index) {
    if (this._hasMore) {
      return (index == this._productList.length - 1)
          ? LoadingWidget()
          : Text('');
    } else {
      return (index == this._productList.length - 1)
          ? Text("---暂无其他数据了--")
          : Text('');
    }
  }

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
                  child: Text(
                    '销量',
                    textAlign: TextAlign.center,
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
                  child: Text(
                    '价格',
                    textAlign: TextAlign.center,
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
                  child: Text(
                    '筛选',
                    textAlign: TextAlign.center,
                  ),
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

  //显示加载中的圈圈：
  _showMore(index) {
    if (this._hasMore) {
      return (index == this._productList.length - 1)
          ? LoadingWidget()
          : Text('');
    } else {
      return (index == this._productList.length - 1)
          ? Text("---暂无其他数据了--")
          : Text('');
    }
  }

  // 商品列表
  Widget _productListWidget() {
    if (this._productList.length > 0) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(80)),
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            //处理图片：
            String pic = this._productList[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');
            //获得每一个元素：
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(180),
                      height: ScreenUtil().setHeight(180),
                      child: Image.network("${pic}", fit: BoxFit.cover),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: ScreenUtil().setHeight(180),
                        margin: EdgeInsets.only(left: 10),
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${this._productList[index].title}",
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
                                    // color:Color.fromRGBO(230, 230, 230, 0.9)
                                  ),
                                  child: Text('4G'),
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
                                )
                              ],
                            ),
                            Text("￥ ${this._productList[index].price}",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  height: 20,
                ),
                this._showMore(index)
              ],
            );
          },
          itemCount: this._productList.length,
        ),
      );
    } else {
      return LoadingWidget();
    }
  }

  /*  Widget _productListWidget() {
    if (this._productList.length > 0) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(80)),
        child: ListView.builder(
          itemCount: this._productList.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            // 图片处理
            String pic = this._productList[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');
            //获得每一个元素：
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(180),
                      height: ScreenUtil().setHeight(180),
                      child: Image.network(
                        // "https://www.itying.com/images/flutter/list2.jpg",
                        '${pic}',
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
                              '${this._productList[index].title}',
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
                                  child: Text('4G'),
                                ),
                                Container(
                                  height: ScreenUtil().setHeight(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  //注意：如果Container里面加上decoration属性，这个时候color���性必须放到BoxDecoration
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color:Color.fromRGBO(230, 230, 230, 0.3)
                                  ),
                                  child: Text('16G'),
                                ),
                              ],
                            ),
                            Text(
                              '￥${this._productList[index].price}',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  height: 20,
                ),
                this._showMore(index),
              ],
            );
          },
        ),
      );
    } else {
      return LoadingWidget();
    }
  }
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品列表'),
      ),
      body: Stack(
        children: <Widget>[
          _productListWidget(),
          _subHeaderWidget(),
        ],
      ),
    );
  }
}
