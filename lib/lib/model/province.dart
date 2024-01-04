import 'package:ketquaxoso/lib/common/const/string_constants.dart';

class Province {
  String? name;
  String? slug;
  String? url;

  Province({this.name, this.slug, this.url});

  Province.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['slug'] = slug;
    data['url'] = url;
    return data;
  }

  static List<Province> genList() {
    var list = <Province>[];
    list.add(Province(
      name: "An Giang",
      slug: "xsag-an-giang", //ok
      url: "${StringConstants.kqProvince}an-giang", //ok
    ));
    list.add(Province(
      name: "Bạc Liêu",
      slug: "xsbl-bac-lieu",//ok
      url: "${StringConstants.kqProvince}bac-lieu", //ok
    ));
    list.add(Province(
      name: "Bến Tre",
      slug: "xsbt-ben-tre",//ok
      url: "${StringConstants.kqProvince}ben-tre", //ok
    ));
    list.add(Province(
      name: "Bình Định",
      slug: "",//TODO roy93~
      url: "${StringConstants.kqProvince}binh-dinh", //ok
    ));
    list.add(Province(
      name: "Bình Dương",
      slug: "",
      url: "${StringConstants.kqProvince}binh-duong",//ok
    ));
    list.add(Province(
      name: "Bình Phước",
      slug: "",
      url: "${StringConstants.kqProvince}binh-phuoc",//ok
    ));
    list.add(Province(
      name: "Bình Thuận",
      slug: "",
      url: "${StringConstants.kqProvince}binh-thuan",//ok
    ));
    list.add(Province(
      name: "Cà Mau",
      slug: "",
      url: "${StringConstants.kqProvince}ca-mau",//ok
    ));
    list.add(Province(
      name: "Cần Thơ",
      slug: "",
      url: "${StringConstants.kqProvince}can-tho",//ok
    ));
    list.add(Province(
      name: "Đà Lạt",
      slug: "",
      url: "${StringConstants.kqProvince}da-lat",//ok
    ));
    list.add(Province(
      name: "Đà Nẵng",
      slug: "",
      url: "${StringConstants.kqProvince}da-nang",//ok
    ));
    list.add(Province(
      name: "Đắk Lắk",
      slug: "",
      url: "${StringConstants.kqProvince}dac-lac",//ok
    ));
    list.add(Province(
      name: "Đắk Nông",
      slug: "",
      url: "${StringConstants.kqProvince}dac-nong",//ok
    ));
    list.add(Province(
      name: "Đồng Nai",
      slug: "",
      url: "${StringConstants.kqProvince}dong-nai",//ok
    ));
    list.add(Province(
      name: "Đồng Tháp",
      slug: "",
      url: "${StringConstants.kqProvince}dong-thap",//ok
    ));
    list.add(Province(
      name: "Gia Lai",
      slug: "",
      url: "${StringConstants.kqProvince}gia-lai",//ok
    ));
    list.add(Province(
      name: "Hậu Giang",
      slug: "",
      url: "${StringConstants.kqProvince}hau-giang",//ok
    ));
    list.add(Province(
      name: "Huế",
      slug: "",
      url: "${StringConstants.kqProvince}thua-thien-hue",//ok
    ));
    list.add(Province(
      name: "Khánh Hoà",
      slug: "",
      url: "${StringConstants.kqProvince}khanh-hoa",//ok
    ));
    list.add(Province(
      name: "Kiên Giang",
      slug: "",
      url: "${StringConstants.kqProvince}kien-giang",//ok
    ));
    list.add(Province(
      name: "Kon Tum",
      slug: "",
      url: "${StringConstants.kqProvince}kon-tum",//ok
    ));
    list.add(Province(
      name: "Long An",
      slug: "",
      url: "${StringConstants.kqProvince}long-an",//ok
    ));
    list.add(Province(
      name: "Ninh Thuận",
      slug: "",
      url: "${StringConstants.kqProvince}ninh-thuan",//ok
    ));
    list.add(Province(
      name: "Phú Yên",
      slug: "",
      url: "${StringConstants.kqProvince}phu-yen",//ok
    ));
    list.add(Province(
      name: "Quảng Bình",
      slug: "",
      url: "${StringConstants.kqProvince}quang-binh",//ok
    ));
    list.add(Province(
      name: "Quảng Nam",
      slug: "",
      url: "${StringConstants.kqProvince}quang-nam",//ok
    ));
    list.add(Province(
      name: "Quảng Ngãi",
      slug: "",
      url: "${StringConstants.kqProvince}quang-ngai",//ok
    ));
    list.add(Province(
      name: "Quảng Trị",
      slug: "",
      url: "${StringConstants.kqProvince}quang-tri",//ok
    ));
    list.add(Province(
      name: "Sóc Trăng",
      slug: "",
      url: "${StringConstants.kqProvince}soc-trang",//ok
    ));
    list.add(Province(
      name: "Tây Ninh",
      slug: "",
      url: "${StringConstants.kqProvince}tay-ninh",//ok
    ));
    list.add(Province(
      name: "Tiền Giang",
      slug: "",
      url: "${StringConstants.kqProvince}tien-giang",//ok
    ));
    list.add(Province(
      name: "TPHCM",
      slug: "",
      url: "${StringConstants.kqProvince}thanh-pho-ho-chi-minh",//ok
    ));
    list.add(Province(
      name: "Trà Vinh",
      slug: "",
      url: "${StringConstants.kqProvince}tra-vinh",//ok
    ));
    list.add(Province(
      name: "Vĩnh Long",
      slug: "",
      url: "${StringConstants.kqProvince}vinh-long",//ok
    ));
    list.add(Province(
      name: "Vũng Tàu",
      slug: "",
      url: "${StringConstants.kqProvince}vung-tau",//ok
    ));
    return list;
  }
}
