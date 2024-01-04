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
      url: "https://xoso.mobi//embedded/kq-tinh?tinh=an-giang",//ok
    ));
    list.add(Province(
      name: "Bạc Liêu",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Bến Tre",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Bình Định",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Bình Dương",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Bình Phước",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Bình Thuận",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Cà Mau",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Cần Thơ",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Đà Lạt",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Đà Nẵng",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Đắk Lắk",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Đắk Nông",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Đồng Nai",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Đồng Tháp",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Gia Lai",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Hậu Giang",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Huế",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Khánh Hoà",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Kiên Giang",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Kon Tum",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Long An",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Ninh Thuận",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Phú Yên",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Quảng Bình",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Quảng Nam",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Quảng Ngãi",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Quảng Trị",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Sóc Trăng",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Tây Ninh",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Tiền Giang",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "TPHCM",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Trà Vinh",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Vĩnh Long",
      slug: "",
      url: "",
    ));
    list.add(Province(
      name: "Vũng Tàu",
      slug: "",
      url: "",
    ));
    return list;
  }
}
