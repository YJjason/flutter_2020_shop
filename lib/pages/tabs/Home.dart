import 'package:flutter/material.dart';
import 'package:flutter_2020/services/SearchServices.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// 引入接口以及 http  请求

import './../../config/config.dart';
import 'package:dio/dio.dart';
//轮播图类模型：
import './../../model/FocusModel.dart';
// 热门推荐模型：
import './../../model/ProductModel.dart';

// 本地缓存
import './../../services/SearchServices.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  // 轮播图数据
  List _focusData = [];
  // 猜你喜欢数据
  List _hotProductList = [];
  // 热门推荐数据
  List _bestProductList = [];
  @override
  // 跳转页面保持当前页面状态
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductList();
    // 本地缓存
    SearchServices.setHistoryData('2333');
    var temp = SearchServices.getHistoryList();
  }

// 获取轮播图数据
  _getFocusData() async {
    var api = '${Config.domain}api/focus';
    var result = await Dio().get(api);
    var focusList = FocusModel.fromJson(result.data);
    setState(() {
      this._focusData = focusList.result;
    });
  }

  //获取猜你喜欢的数据：
  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);
    var _hotProductList = ProductModel.fromJson(result.data);
    setState(() {
      this._hotProductList = _hotProductList.result;
    });
  }

  //获取热门推荐的数据：
  _getBestProductList() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var bestProductList = ProductModel.fromJson(result.data);
    setState(() {
      this._bestProductList = bestProductList.result;
    });
  }

  // 轮播图
  Widget _swiperWidget() {
    /*  List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"}
    ]; */
    if (this._focusData.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String pic = this._focusData[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return new Image.network(
                "${pic}",
                fit: BoxFit.fill,
              );
            },
            itemCount: this._focusData.length,
            pagination: new SwiperPagination(),
            control: new SwiperControl(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return Text('加载中~');
    }
  }

  // 标题
  Widget _titleWidget(value) {
    return Container(
      height: ScreenUtil().setHeight(46),
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.red,
            width: ScreenUtil().setWidth(10),
          ),
        ),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }

  //热门商品：
  Widget _hotProductListWidget() {
    if (this._hotProductList.length > 0) {
      return Container(
        height: ScreenUtil().setHeight(240),
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        // width: double.infinity, //寬度自適應
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (contxt, index) {
            String sPic = this._hotProductList[index].sPic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');
            return Column(
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(140),
                  width: ScreenUtil().setWidth(140),
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(21)),
                  child: Image.network("${sPic}", fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  height: ScreenUtil().setHeight(44),
                  child: Text(
                    "￥${this._hotProductList[index].price}",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          },
          itemCount: this._hotProductList.length,
        ),
      );
    } else {
      return Text('暂无热门推荐数据');
    }
  }

  // 首页商品列表
  Widget _recProductItemListWidget() {
    var itemWidth = (ScreenUtil.screenWidth - 30) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: this._bestProductList.map((value) {
          //图片：
          var sPic = value.sPic;
          sPic = Config.domain + sPic.replaceAll('\\', '/');

          return InkWell(
            onTap: () {
              print("productContent");
              /*  Navigator.pushNamed(context, '/productContent',
                  arguments: {"id": value.sId}); */
              Navigator.pushNamed(context, '/productContent',
                  arguments: {"id": value.sId});
            },
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              width: itemWidth,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1)),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network("${sPic}", fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                    child: Text(
                      "${value.title}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${value.price}",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "￥${value.oldPrice}",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        _titleWidget("猜你喜欢"),
        _hotProductListWidget(),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        _titleWidget("热门推荐"),
        _recProductItemListWidget(),
      ],
    );
  }
}
