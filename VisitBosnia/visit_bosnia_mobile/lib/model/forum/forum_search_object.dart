class ForumSearchObject {
  String? title;
  int? cityId;
  bool? includeCity;

  ForumSearchObject({this.title, this.cityId, this.includeCity});

  ForumSearchObject.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    cityId = json['cityId'];
    includeCity = json['includeCity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['cityId'] = this.cityId;
    data['includeCity'] = this.includeCity;
    return data;
  }
}
