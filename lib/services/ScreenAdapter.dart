/*
 * @Author: Jason_Ma
 * @Date: 2020-07-13 10:16:40
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 15:19:47
 * @FilePath: /flutter_2020_shop/lib/services/ScreenAdapter.dart
 */
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static init(context) {
    ScreenUtil.init(context, width: 750, height: 1334);
  }

  static height(double value) {
    return ScreenUtil().setHeight(value);
  }

  static width(double value) {
    return ScreenUtil().setWidth(value);
  }

  /* static getScreenHeight() {
    return ScreenUtil.screenHeightDp;
  } */

  /*  static getScreenWidth() {
    return ScreenUtil.screenWidthDp;
  } */

  static getScreenPxHeight() {
    return ScreenUtil.screenHeight;
  }

  static getScreenPxWidth() {
    return ScreenUtil.screenWidth;
  }

  static size(double value) {
    return ScreenUtil().setSp(value);
  }
}
