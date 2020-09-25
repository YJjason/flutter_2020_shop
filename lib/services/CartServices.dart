/*
 * @Author: Jason_Ma
 * @Date: 2020-09-24 17:25:13
 * @LastEditors: Jason_Ma
 * @LastEditTime: 2020-09-24 17:29:02
 * @FilePath: /flutter_2020_shop/lib/services/CartServices.dart
 */
class CartServices {
  static addCart(item) {
    //把对象转换成Map类型的数据
    item = CartServices.formatCartData(item);
  }
  /* {
    _id: 5a0425bc010e711234661439, 
    title: 磨砂牛皮男休闲鞋-有属性,
    price: 688, 
    selectedAttr: 牛皮 ,系带,黄色,
    count: 3, 
    pic: public\upload\RinsvExKu7Ed-ocs_7W1DxYO.png, 
    checked: true
    } */

  //过滤数据
  static formatCartData(item) {
    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price;
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = item.pic;
    //是否选中
    data['checked'] = true;
    print('data -- ${data}');
    return data;
  }
}
