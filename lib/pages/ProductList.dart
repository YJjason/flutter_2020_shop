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
// 是否有搜索的数据：
  bool _hasData = true;
  // 一级导航数据
  /*
  价格升序：sort=price_1
  价格降序：sort=price_-1
  销量升序：sort=salecount_1
  销量降序：sort=salecount_-1
   */
  List _subHeaderList = [
    {"id": 1, "title": "综合", "fileds": 'all', "sort": -1},
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"},
  ];
  //当前选中 导航id
  int _selectHeaderId = 1;

  //配置search搜索框的值：
  var _initKeywordsController = new TextEditingController();
  //cid
  var _cid;
  var _keywords;

  @override
  void initState() {
    super.initState();
    this._cid = widget.arguments["cid"];
    this._keywords = widget.arguments["keywords"];
    //给search框框赋值：
    this._initKeywordsController.text = this._keywords;

    widget.arguments['keywords'] == null
        ? this._initKeywordsController.text = ''
        : this._initKeywordsController.text = widget.arguments['keywords'];

    // 获取商品数据
    _getProductListData();
    //监听滚动条滚动事件：
    _scrollController.addListener(() {
      // _scrollController.position.pixels //获取滚动条滚动高度
      // _scrollController.position.maxScrollExtent //获取页面滚动高度：
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (this.flag && this._hasMore) {
          _getProductListData();
        }
      }
    });
  }

  //获取商品列表的数据：
  _getProductListData() async {
    setState(() {
      this.flag = false;
    });
    var api = '';
    if (this._keywords == null) {
      api =
          '${Config.domain}api/plist?cid=${widget.arguments["cid"]}&page=${_page}&sort=${this._sort}&pageSize=${_pageSize}';
    } else {
      api =
          '${Config.domain}api/plist?search=${this._keywords}&page=${_page}&sort=${this._sort}&pageSize=${_pageSize}';
    }

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
    //判断是否有搜索的数据：
    if (productList.result.length == 0) {
      setState(() {
        this._hasData = false;
      });
    } else {
      setState(() {
        this._hasData = true;
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
          children: this._subHeaderList.map((value) {
            return Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(20), 0,
                      ScreenUtil().setHeight(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${value['title']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: (this._selectHeaderId == value['id'])
                                ? Colors.red
                                : Colors.black),
                      ),
                      _showIcon(value['id']),
                    ],
                  ),
                ),
                onTap: () {
                  _subHeaderChange(value['id']);
                },
              ),
            );
          }).toList(),
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
                                  //��意：如果Container里面加上decoration属性，这个时候color属性必须放到BoxDecoration
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

  //导航改变的时候触发：
  _subHeaderChange(id) {
    if (id == 4) {
      _scaffoldKey.currentState.openEndDrawer();
    }
    setState(() {
      this._selectHeaderId = id;
      this._sort =
          "${this._subHeaderList[id - 1]['fileds']}_${this._subHeaderList[id - 1]['sort']}";
      // 重置分页
      this._page = 1;
      //重置数据
      this._productList = [];
      // 重置默认排序方式
      this._subHeaderList[id - 1]['sort'] =
          this._subHeaderList[id - 1]['sort'] * -1;

      //重置_hasMore
      this._hasMore = true;
      //重新请求数据：
      this._getProductListData();
    });
  }

  //显示Header icon
  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (this._subHeaderList[id - 1]['sort'] == 1) {
        return Icon(Icons.arrow_drop_down);
      } else {
        return Icon(Icons.arrow_drop_up);
      }
    }
    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品列表'),
        actions: <Widget>[Text('232')],
      ),
      endDrawer: Drawer(
        child: Container(
          child: Text('实现筛选功能'),
        ),
      ),
      body: _hasData
          ? Stack(
              children: <Widget>[
                _productListWidget(),
                _subHeaderWidget(),
              ],
            )
          : Center(
              child: Text('没有你要浏览的数据'),
            ),
    );
  }
}
