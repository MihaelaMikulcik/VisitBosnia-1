import 'package:visit_bosnia_mobile/model/attractions/attraction.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

class AttractionProvider extends BaseProvider<Attraction> {
  AttractionProvider() : super("Attraction");

  @override
  Attraction fromJson(data) {
    // TODO: implement fromJson
    return Attraction.fromJson(data);
  }
}
