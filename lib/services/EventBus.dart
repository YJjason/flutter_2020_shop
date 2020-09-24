/*
 * @Author: Jason_Ma
 * @Date: 2020-09-24 16:54:45
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 17:14:22
 * @FilePath: /flutter_2020_shop/lib/services/EventBus.dart
 */
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ProductContentEvent {
  String str;
  ProductContentEvent(String str) {
    this.str = str;
  }
}
