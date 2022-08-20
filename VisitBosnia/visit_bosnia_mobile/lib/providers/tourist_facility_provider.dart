import 'package:visit_bosnia_mobile/model/tourist_facility.dart';

import 'base_provider.dart';

class TouristFacilityProvider extends BaseProvider<TouristFacility> {
  TouristFacilityProvider() : super("TouristFacility");
  @override
  TouristFacility fromJson(data) {
    // TODO: implement fromJson
    return TouristFacility.fromJson(data);
  }
}
