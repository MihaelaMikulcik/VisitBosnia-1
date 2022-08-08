class AttractionSearchObject {
  String? searchText;
  bool? includeIdNavigation;
  int? categoryId;

  AttractionSearchObject(
      {this.searchText, this.includeIdNavigation, this.categoryId});

  AttractionSearchObject.fromJson(Map<String, dynamic> json) {
    searchText = json['searchText'];
    includeIdNavigation = json['includeIdNavigation'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchText'] = this.searchText;
    data['includeIdNavigation'] = this.includeIdNavigation;
    data['categoryId'] = this.categoryId;
    return data;
  }
}
