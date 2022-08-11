class AppUserFavourite {
  int? id;
  int? appUserId;
  int? touristFacilityId;

  AppUserFavourite({this.id, this.appUserId, this.touristFacilityId});

  AppUserFavourite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appUserId = json['appUserId'];
    touristFacilityId = json['touristFacilityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appUserId'] = this.appUserId;
    data['touristFacilityId'] = this.touristFacilityId;
    return data;
  }
}
