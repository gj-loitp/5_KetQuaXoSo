import 'package:ketquaxoso/mckimquyen/model/province.dart';

class History {
  String? id;
  String? number;
  String? datetime;
  String? callFromScreen;
  Province? province;

  History({
    this.id,
    this.number,
    this.datetime,
    this.callFromScreen,
    this.province,
  });

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    datetime = json['datetime'];
    callFromScreen = json['callFromScreen'];
    province = json['province'] != null ? Province.fromJson(json['province']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    data['datetime'] = datetime;
    data['callFromScreen'] = callFromScreen;
    if (province != null) {
      data['province'] = province!.toJson();
    }
    return data;
  }
}
