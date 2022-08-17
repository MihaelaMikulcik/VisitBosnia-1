class ReviewSearchObject {
  String? searchText;
  bool? includeTouristFacility;
  bool? includeAppUser;
  int? agencyId;
  int? facilityId;
  int? rating;

  ReviewSearchObject(
      {this.searchText,
      this.includeTouristFacility,
      this.includeAppUser,
      this.agencyId,
      this.facilityId,
      this.rating});

  ReviewSearchObject.fromJson(Map<String, dynamic> json) {
    searchText = json['searchText'];
    includeTouristFacility = json['includeTouristFacility'];
    includeAppUser = json['includeAppUser'];
    agencyId = json['agencyId'];
    facilityId = json['facilityId'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchText'] = this.searchText;
    data['includeTouristFacility'] = this.includeTouristFacility;
    data['includeAppUser'] = this.includeAppUser;
    data['agencyId'] = this.agencyId;
    data['categoryId'] = this.facilityId;
    data['cityId'] = this.rating;
    return data;
  }
}
