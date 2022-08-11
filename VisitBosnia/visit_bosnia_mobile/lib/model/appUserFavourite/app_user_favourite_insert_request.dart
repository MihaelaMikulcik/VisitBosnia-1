import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';

class AppUserFavouriteInsertRequest {
  int? appUserId;
  int? touristFacilityId;

  AppUserFavouriteInsertRequest({
    this.appUserId,
    this.touristFacilityId,
  });

  AppUserFavouriteInsertRequest.fromJson(Map<String, dynamic> json) {
    appUserId = json['appUserId'];
    touristFacilityId = json['touristFacilityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appUserId'] = this.appUserId;
    data['touristFacilityId'] = this.touristFacilityId;
    return data;
  }
}
