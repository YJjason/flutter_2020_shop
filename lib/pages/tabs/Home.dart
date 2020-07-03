import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 轮播图
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"}
    ];
    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemCount: imgList.length,
          autoplay: true,
          pagination: new SwiperPagination(), //默认分页器
          control: new SwiperControl(), //默认分页按钮
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              imgList[index]['url'],
              fit: BoxFit.fill,
            );
          },
        ),
      ),
    );
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
    return Container(
      height: ScreenUtil().setHeight(240),
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      // width: double.infinity, //寬度自適應
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(140),
                width: ScreenUtil().setWidth(140),
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(21)),
                child: Image.network(
                  'https://www.itying.com/images/flutter/hot${index + 1}.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                height: ScreenUtil().setHeight(44),
                child: Text('第${index}条'),
              )
            ],
          );
        },
        itemCount: 9,
      ),
    );
  }

  // 首页商品列表
  Widget _recProductItemListWidget() {
    var itemWidth = (ScreenUtil.screenWidth - 30) / 2;
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      width: itemWidth,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(
                "https://www.itying.com/images/flutter/list1.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
            child: Text(
              '2020随访随访地方2020随访随访地方,2020随访随访地方,2020随访随访地方,,',
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
                    '2323',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '3434',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
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
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: <Widget>[
              _recProductItemListWidget(),
              _recProductItemListWidget(),
              _recProductItemListWidget(),
              _recProductItemListWidget(),
              _recProductItemListWidget(),
              _recProductItemListWidget()
            ],
          ),
        )
      ],
    );
  }
}
