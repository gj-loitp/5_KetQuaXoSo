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
      slug: "",
      url: "",
    ));
    return list;
  }
}
