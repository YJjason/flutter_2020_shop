/*
 * @Author: Jason_Ma
 * @Date: 2020-09-16 13:44:29
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-23 16:07:06
 * @FilePath: /flutter_2020_shop/lib/pages/ProductContent/ProductContentSecond.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ProductContentSecond extends StatefulWidget {
  final List _productContentList;
  ProductContentSecond(this._productContentList, {Key key}) : super(key: key);
  @override
  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond> {
  InAppWebViewController _webViewController;
  String url = "";
  var _id = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._id = widget._productContentList[0].sId;
  }

  @override
  Widget build(BuildContext context) {
    // 商品详情
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrl: "http://jd.itying.com/pcontent?id=${this._id}",
              // initialUrl: "https://github.com/flutter",
              // initialFile: "assets/index.html",
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
                useShouldOverrideUrlLoading: true,
              )),
              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;
                print("onWebViewCreated");
              },
              onLoadStart: (InAppWebViewController controller, String url) {
                print("onLoadStart $url");
                setState(() {
                  this.url = url;
                });
              },
              onLoadStop:
                  (InAppWebViewController controller, String url) async {
                print("onLoadStop $url");
                setState(() {
                  this.url = url;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
