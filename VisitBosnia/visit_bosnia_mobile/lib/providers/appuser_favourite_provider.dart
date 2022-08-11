import 'package:visit_bosnia_mobile/model/appUserFavourite/app_user_favourite.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/events/event.dart';

class AppUserFavouriteProvider extends BaseProvider<AppUserFavourite> {
  AppUserFavouriteProvider() : super("AppUserFavourite");
  @override
  AppUserFavourite fromJson(data) {
    // TODO: implement fromJson
    return AppUserFavourite.fromJson(data);
  }
}
