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
      slug: "xsbdi-binh-dinh",//ok
      url: "${StringConstants.kqProvince}binh-dinh", //ok
    ));
    list.add(Province(
      name: "Bình Dương",
      slug: "xsbd-binh-duong",//ok
      url: "${StringConstants.kqProvince}binh-duong",//ok
    ));
    list.add(Province(
      name: "Bình Phước",
      slug: "xsbp-binh-phuoc",//ok
      url: "${StringConstants.kqProvince}binh-phuoc",//ok
    ));
    list.add(Province(
      name: "Bình Thuận",
      slug: "xsbth-binh-thuan",//ok
      url: "${StringConstants.kqProvince}binh-thuan",//ok
    ));
    list.add(Province(
      name: "Cà Mau",
      slug: "xscm-ca-mau",//ok
      url: "${StringConstants.kqProvince}ca-mau",//ok
    ));
    list.add(Province(
      name: "Cần Thơ",
      slug: "xsct-can-tho",//ok
      url: "${StringConstants.kqProvince}can-tho",//ok
    ));
    list.add(Province(
      name: "Đà Lạt",
      slug: "xsdl-da-lat",//ok
      url: "${StringConstants.kqProvince}da-lat",//ok
    ));
    list.add(Province(
      name: "Đà Nẵng",
      slug: "xsdna-da-nang",//ok
      url: "${StringConstants.kqProvince}da-nang",//ok
    ));
    list.add(Province(
      name: "Đắk Lắk",
      slug: "xsdlk-dak-lak",//ok
      url: "${StringConstants.kqProvince}dac-lac",//ok
    ));
    list.add(Province(
      name: "Đắk Nông",
      slug: "xsdno-dak-nong",//ok
      url: "${StringConstants.kqProvince}dac-nong",//ok
    ));
    list.add(Province(
      name: "Đồng Nai",
      slug: "xsdn-dong-nai",//ok
      url: "${StringConstants.kqProvince}dong-nai",//ok
    ));
    list.add(Province(
      name: "Đồng Tháp",
      slug: "xsdt-dong-thap",//ok
      url: "${StringConstants.kqProvince}dong-thap",//ok
    ));
    list.add(Province(
      name: "Gia Lai",
      slug: "xsgl-gia-lai",//ok
      url: "${StringConstants.kqProvince}gia-lai",//ok
    ));
    list.add(Province(
      name: "Hậu Giang",
      slug: "xshg-hau-giang",//ok
      url: "${StringConstants.kqProvince}hau-giang",//ok
    ));
    list.add(Province(
      name: "Huế",
      slug: "xstth-hue",//ok
      url: "${StringConstants.kqProvince}thua-thien-hue",//ok
    ));
    list.add(Province(
      name: "Khánh Hoà",
      slug: "xskh-khanh-hoa",//ok
      url: "${StringConstants.kqProvince}khanh-hoa",//ok
    ));
    list.add(Province(
      name: "Kiên Giang",
      slug: "xskg-kien-giang",//ok
      url: "${StringConstants.kqProvince}kien-giang",//ok
    ));
    list.add(Province(
      name: "Kon Tum",
      slug: "xskt-kon-tum",//ok
      url: "${StringConstants.kqProvince}kon-tum",//ok
    ));
    list.add(Province(
      name: "Long An",
      slug: "xsla-long-an",//ok
      url: "${StringConstants.kqProvince}long-an",//ok
    ));
    list.add(Province(
      name: "Ninh Thuận",
      slug: "xsnt-ninh-thuan",//ok
      url: "${StringConstants.kqProvince}ninh-thuan",//ok
    ));
    list.add(Province(
      name: "Phú Yên",
      slug: "xspy-phu-yen",//ok
      url: "${StringConstants.kqProvince}phu-yen",//ok
    ));
    list.add(Province(
      name: "Quảng Bình",
      slug: "xsqb-quang-binh",//ok
      url: "${StringConstants.kqProvince}quang-binh",//ok
    ));
    list.add(Province(
      name: "Quảng Nam",
      slug: "xsqna-quang-nam",//ok
      url: "${StringConstants.kqProvince}quang-nam",//ok
    ));
    list.add(Province(
      name: "Quảng Ngãi",
      slug: "xsqn-quang-ngai",//ok
      url: "${StringConstants.kqProvince}quang-ngai",//ok
    ));
    list.add(Province(
      name: "Quảng Trị",
      slug: "xsqt-quang-tri",//ok
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
