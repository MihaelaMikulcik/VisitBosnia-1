import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';

class ReviewInsertRequest {
  int? appUserId;
  int? touristFacilityId;
  int? rating;
  String? text;

  ReviewInsertRequest({
    this.appUserId,
    this.touristFacilityId,
    this.rating,
    this.text,
  });

  ReviewInsertRequest.fromJson(Map<String, dynamic> json) {
    appUserId = json['appUserId'];
    touristFacilityId = json['touristFacilityId'];
    rating = json['rating'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appUserId'] = this.appUserId;
    data['touristFacilityId'] = this.touristFacilityId;
    data['rating'] = this.rating;
    data['text'] = this.text;
    return data;
  }
}
