class EventOrderSearchObject {
  String? searchText;
  bool? includeIdNavigation;
  bool? includeAppUser;
  int? categoryId;
  int? cityId;
  int? eventId;
  int? agencyMemberId;

  EventOrderSearchObject(
      {this.searchText,
      this.includeIdNavigation,
      this.categoryId,
      this.includeAppUser,
      this.eventId,
      this.agencyMemberId});

  EventOrderSearchObject.fromJson(Map<String, dynamic> json) {
    searchText = json['searchText'];
    includeIdNavigation = json['includeIdNavigation'];
    categoryId = json['categoryId'];
    cityId = json['cityId'];
    includeAppUser = json['includeAppUser'];
    eventId = json['eventId'];
    agencyMemberId = json['agencyMemberId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchText'] = this.searchText;
    data['includeIdNavigation'] = this.includeIdNavigation;
    data['categoryId'] = this.categoryId;
    data['cityId'] = this.cityId;
    data['includeAppUser'] = this.includeAppUser;
    data['eventId'] = this.eventId;
    data['agencyMemberId'] = this.agencyMemberId;
    return data;
  }
}
