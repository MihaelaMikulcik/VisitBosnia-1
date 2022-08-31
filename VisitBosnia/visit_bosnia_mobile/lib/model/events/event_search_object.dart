class EventSearchObject {
  String? searchText;
  bool? includeIdNavigation;
  bool? includeIdNavigationPartial;
  bool? includeAgencyMember;
  bool? includeAgency;
  int? categoryId;
  int? cityId;
  int? agencyId;
  int? agencyMemberId;

  EventSearchObject(
      {this.searchText,
      this.includeIdNavigation,
      this.includeIdNavigationPartial,
      this.includeAgencyMember,
      this.includeAgency,
      this.cityId,
      this.categoryId,
      this.agencyId,
      this.agencyMemberId});

  EventSearchObject.fromJson(Map<String, dynamic> json) {
    searchText = json['searchText'];
    includeIdNavigation = json['includeIdNavigation'];
    includeIdNavigationPartial = json['includeIdNavigationPartial'];
    includeAgencyMember = json['includeAgencyMember'];
    includeAgency = json['includeAgency'];
    categoryId = json['categoryId'];
    cityId = json['cityId'];
    agencyId = json['agencyId'];
    agencyMemberId = json['agencyMemberId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchText'] = this.searchText;
    data['includeIdNavigation'] = this.includeIdNavigation;
    data['includeIdNavigationPartial'] = this.includeIdNavigationPartial;
    data['includeAgencyMember'] = this.includeAgencyMember;
    data['includeAgency'] = this.includeAgency;
    data['categoryId'] = this.categoryId;
    data['cityId'] = this.cityId;
    data['agencyId'] = this.agencyId;
    data['agencyMemberId'] = this.agencyMemberId;
    return data;
  }
}
