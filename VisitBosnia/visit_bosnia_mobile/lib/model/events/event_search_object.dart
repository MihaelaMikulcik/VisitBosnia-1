class EventSearchObject {
  String? searchText;
  bool? includeIdNavigation;
  bool? includeAgencyMember;
  bool? includeAgency;

  EventSearchObject(
      {this.searchText,
      this.includeIdNavigation,
      this.includeAgencyMember,
      this.includeAgency});

  EventSearchObject.fromJson(Map<String, dynamic> json) {
    searchText = json['searchText'];
    includeIdNavigation = json['includeIdNavigation'];
    includeAgencyMember = json['includeAgencyMember'];
    includeAgency = json['includeAgency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchText'] = this.searchText;
    data['includeIdNavigation'] = this.includeIdNavigation;
    data['includeAgencyMember'] = this.includeAgencyMember;
    data['includeAgency'] = this.includeAgency;
    return data;
  }
}
