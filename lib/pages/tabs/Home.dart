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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(height: 10),
        _titleWidget("猜你喜欢"),
        _hotProductListWidget(),
        SizedBox(height: 10),
        _swiperWidget(),
      ],
    );
  }
}
