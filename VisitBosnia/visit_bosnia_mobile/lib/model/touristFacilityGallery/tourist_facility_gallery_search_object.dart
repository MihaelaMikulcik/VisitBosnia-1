class TouristFacilityGallerySearchObject {
  int? facilityId;
  bool? isThumbnail;

  TouristFacilityGallerySearchObject({
    this.facilityId,
    this.isThumbnail,
  });

  TouristFacilityGallerySearchObject.fromJson(Map<String, dynamic> json) {
    facilityId = json['facilityId'];
    isThumbnail = json['isThumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facilityId'] = this.facilityId;
    data['isThumbnail'] = this.isThumbnail;
    return data;
  }
}
