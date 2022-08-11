class AppUserFavouriteSearchObject {
  bool? includeAppUser;
  bool? includeTouristFacility;
  int? appUserId;
  int? touristFacilityId;

  AppUserFavouriteSearchObject(
      {this.includeAppUser,
      this.includeTouristFacility,
      this.appUserId,
      this.touristFacilityId});

  AppUserFavouriteSearchObject.fromJson(Map<String, dynamic> json) {
    includeAppUser = json['includeAppUser'];
    includeTouristFacility = json['includeTouristFacility'];
    appUserId = json['appUserId'];
    touristFacilityId = json['touristFacilityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['includeAppUser'] = this.includeAppUser;
    data['includeTouristFacility'] = this.includeTouristFacility;
    data['appUserId'] = this.appUserId;
    data['touristFacilityId'] = this.touristFacilityId;
    return data;
  }
}
