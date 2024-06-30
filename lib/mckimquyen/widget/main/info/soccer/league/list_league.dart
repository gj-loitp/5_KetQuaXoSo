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

