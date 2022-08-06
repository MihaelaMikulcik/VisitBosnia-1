import 'package:flutter/cupertino.dart';
import 'package:visit_bosnia_mobile/model/id_navigation.dart';
import 'package:visit_bosnia_mobile/model/touristFacilityGallery/tourist_facility_gallery.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

class TouristFacilityGalleryProvider
    extends BaseProvider<TouristFacilityGallery> {
  TouristFacilityGalleryProvider() : super("TouristFacilityGallery");

  @override
  fromJson(data) {
    // TODO: implement fromJson
    return TouristFacilityGallery.fromJson(data);
  }
}
