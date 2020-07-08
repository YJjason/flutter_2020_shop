import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 搜索 本地缓存

import './../services/SearchServices.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keywords;
  List _historyListData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 获取当前本地缓存

    _historyListWidget();
    _getHistoryData();
  }

  _getHistoryData() async {
    var _historyListData = SearchServices.getHistoryList();
    setState(() {
      this._historyListData = _historyListData;
    });
  }

// 历史 widget
  Widget _historyListWidget() {
    if (this._historyListData.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text('历史记录', style: Theme.of(context).textTheme.title),
          ),
          Divider(),
          Column(
            children: this._historyListData.map((value) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text('${value}'),
                  ),
                  Divider()
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  SearchServices.removeHistoryList();
                  this._getHistoryData();
                },
                child: Container(
                  width: ScreenUtil().setWidth(400),
                  height: ScreenUtil().setHeight(64),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.delete), Text('清空历史记录')],
                  ),
                ),
              )
            ],
          )
        ],
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)),
            onChanged: (value) {
              this._keywords = value;
            },
          ),
          height: ScreenUtil().setHeight(68),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              height: ScreenUtil().setHeight(68),
              width: ScreenUtil().setWidth(80),
              child: Row(
                children: <Widget>[Text('搜索')],
              ),
            ),
            onTap: () {
              // 保存搜索关键字到本地
              SearchServices.setHistoryData(this._keywords);
              Navigator.pushReplacementNamed(context, '/productList',
                  arguments: {"keywords": this._keywords});
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              child: Text('热搜', style: Theme.of(context).textTheme.title),
            ),
            Divider(),
            Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('女装'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('女装'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('女装'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('女装'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('女装'),
                )
              ],
            ),
            SizedBox(height: 10),
            //历史记录：
            _historyListWidget()
          ],
        ),
      ),
    );
  }
}
