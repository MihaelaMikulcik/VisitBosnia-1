import 'package:flutter/cupertino.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/city/city.dart';

class CityProvider extends BaseProvider<City> {
  CityProvider() : super("City");

  @override
  City fromJson(data) {
    // TODO: implement fromJson
    return City.fromJson(data);
  }
}
