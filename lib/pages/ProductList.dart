// 商品列表
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './../config/config.dart';
import 'package:dio/dio.dart';

class ProductListPage extends StatefulWidget {
  ProductListPage({Key key, arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品列表'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
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
      ),
    );
  }
}
