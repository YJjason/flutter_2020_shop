// 分类 商品模型

class CateModel {
  String _id;

  String get name => _id;
  set name(v) => _id = v;
  List<CateItemModel> result;
  CateModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<CateItemModel>();
      json['result'].forEach((v) {
        result.add(new CateItemModel.fromJson(v));
      });
    }
  }
}

class CateItemModel {
  String sId;
  String title;
  Object status;
  String pic;
  String pid;
  String sort;

  CateItemModel({
    this.sId,
    this.title,
    this.status,
    this.pic,
    this.pid,
    this.sort,
  });

  CateItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    pid = json['pid'];
    sort = json['sort'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data["status"] = this.status;
    data['pic'] = this.pic;
    data['pid'] = this.pid;
    data["sort"] = this.sort;
  }
}
