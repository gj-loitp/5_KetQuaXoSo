class ListLeague {
  List<String>? leagues;
  int? status;

  ListLeague({this.leagues, this.status});

  ListLeague.fromJson(Map<String, dynamic> json) {
    leagues = json['leagues'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leagues'] = leagues;
    data['status'] = status;
    return data;
  }
}

class League {
  static String leagueIdDefault = "12325";
  String? id;
  String? name;
  String? src;
  bool? isSelected;

  League({
    this.id,
    this.name,
    this.src,
    this.isSelected,
  });

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    src = json['src'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['src'] = src;
    data['isSelected'] = isSelected;
    return data;
  }
}

class Team {
  static String teamIdDefault = "461";
  String? id;
  String? name;
  String? src;
  bool? isSelected;

  Team({
    this.id,
    this.name,
    this.src,
    this.isSelected,
  });

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    src = json['src'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['src'] = src;
    data['isSelected'] = isSelected;
    return data;
  }
}
