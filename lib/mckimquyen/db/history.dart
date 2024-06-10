import 'package:ketquaxoso/mckimquyen/model/province.dart';

class History {
  String? id;
  String? callFromScreen;
  Province? province;

  History({
    this.id,
    this.callFromScreen,
    this.province,
  });

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    callFromScreen = json['callFromScreen'];
    province = json['province'] != null ? Province.fromJson(json['province']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['callFromScreen'] = callFromScreen;
    if (province != null) {
      data['province'] = province!.toJson();
    }
    return data;
  }
}
