import 'package:visit_bosnia_mobile/model/id_navigation.dart';

import 'base_provider.dart';

class TouristFacilityProvider extends BaseProvider<IdNavigation> {
  TouristFacilityProvider() : super("TouristFacility");
  @override
  IdNavigation fromJson(data) {
    // TODO: implement fromJson
    return IdNavigation.fromJson(data);
  }
}
