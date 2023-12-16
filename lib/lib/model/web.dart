class Web {
  int? stt;
  String? data;

  Web({this.stt, this.data});

  Web.fromJson(Map<String, dynamic> json) {
    stt = json['stt'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stt'] = stt;
    data['data'] = this.data;
    return data;
  }
}
