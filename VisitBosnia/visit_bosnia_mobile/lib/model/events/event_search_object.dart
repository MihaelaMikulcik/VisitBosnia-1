class EventSearchObject {
  String? searchText;
  bool? includeIdNavigation;
  bool? includeAgencyMember;
  bool? includeAgency;
  int? categoryId;

  EventSearchObject(
      {this.searchText,
      this.includeIdNavigation,
      this.includeAgencyMember,
      this.includeAgency,
      this.categoryId});

  EventSearchObject.fromJson(Map<String, dynamic> json) {
    searchText = json['searchText'];
    includeIdNavigation = json['includeIdNavigation'];
    includeAgencyMember = json['includeAgencyMember'];
    includeAgency = json['includeAgency'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchText'] = this.searchText;
    data['includeIdNavigation'] = this.includeIdNavigation;
    data['includeAgencyMember'] = this.includeAgencyMember;
    data['includeAgency'] = this.includeAgency;
    data['categoryId'] = this.categoryId;
    return data;
  }
}
