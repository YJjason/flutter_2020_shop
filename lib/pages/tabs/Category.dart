import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './../../config/config.dart';
import 'package:dio/dio.dart';

//商品模型
import './../../model/CateModel.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLeftCateData();
  }

  // 左侧列表数据
  _getLeftCateData() async {
    var api = '${Config.domain}api/pcate';
    var result = await new Dio().get(api);
    var leftCateList = CateModel.fromJson(result.data);
    setState(() {
      this._leftCateList = leftCateList.result;
    });

    _getRightCateData(this._leftCateList[0].sId);
  }

  // 右侧数据
  _getRightCateData(pid) async {
    var api = '${Config.domain}api/pcate?pid=${pid}';
    var result = await new Dio().get(api);
    var rightCateList = CateModel.fromJson(result.data);
    setState(() {
      this._rightCateList = rightCateList.result;
    });
    this._rightCateList.map((value) {
      print('211111----${value.title}');
    });
  }
  // 左侧组件

  Widget _leftCateWidget(leftWidth) {
    if (this._leftCateList.length > 0) {
      return Container(
        width: leftWidth,
        height: double.infinity,
        child: ListView.builder(
          itemCount: this._leftCateList.length,
          itemBuilder: (centext, index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      this._selectIndex = index;
                      this._getRightCateData(this._leftCateList[index].sId);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(56),
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                    child: Text(
                      '${this._leftCateList[index].title}',
                      textAlign: TextAlign.center,
                    ),
                    color: this._selectIndex == index
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            );
          },
        ),
      );
    } else {
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  //右侧组件：
  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (this._rightCateList.length > 0) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
            itemCount: this._rightCateList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: rightItemWidth / rightItemHeight,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              //处理图片：
              String pic = this._rightCateList[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return InkWell(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                          '${pic}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(32),
                        child: Text('${this._rightCateList[index].title}'),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  print('sId-----${this._rightCateList[index].sId}');
                  Navigator.pushNamed(
                    context,
                    '/productList',
                    arguments: {
                      "cid": this._rightCateList[index].sId,
                    },
                  );
                },
              );
            },
          ),
        ),
      );
    } else {
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: Text('加载中...'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //计算右侧GridView宽高比：
    // var leftWidth = ScreenAdaper.getScreenWidth() / 4;
    var leftWidth = ScreenUtil.screenWidth / 4;
    //右侧宽高=总宽度-左侧宽度-Gridview外层元素左右的Padding值-GridView中间的间距
    var rightItemWidth = (ScreenUtil.screenWidth - leftWidth - 20 - 30) / 3;
    rightItemWidth = ScreenUtil().setWidth(rightItemWidth);
    var rightItemHeight = rightItemWidth + ScreenUtil().setHeight(32);
    return Row(
      children: <Widget>[
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeight),
      ],
    );
  }
}
