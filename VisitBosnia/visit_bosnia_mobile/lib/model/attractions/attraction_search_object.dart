class AttractionSearchObject {
  String? searchText;
  bool? includeIdNavigation;

  AttractionSearchObject({
    this.searchText,
    this.includeIdNavigation,
  });

  AttractionSearchObject.fromJson(Map<String, dynamic> json) {
    searchText = json['searchText'];
    includeIdNavigation = json['includeIdNavigation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchText'] = this.searchText;
    data['includeIdNavigation'] = this.includeIdNavigation;
    return data;
  }
}
