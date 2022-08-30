import 'package:visit_bosnia_mobile/model/appUserFavourite/app_user_favourite.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/appUserFavourite/app_user_favourite_search_object.dart';
import '../model/events/event.dart';
import 'appuser_provider.dart';

class AppUserFavouriteProvider extends BaseProvider<AppUserFavourite> {
  AppUserFavouriteProvider() : super("AppUserFavourite");
  @override
  AppUserFavourite fromJson(data) {
    // TODO: implement fromJson
    return AppUserFavourite.fromJson(data);
  }

  late List<AppUserFavourite> favorites = [];

  Future loadAppUserFavourite() async {
    try {
      var search =
          AppUserFavouriteSearchObject(appUserId: AppUserProvider.userData.id);
      var tempFav = await get(search.toJson());
      favorites = tempFav;
    } catch (e) {
      favorites = [];
    }
  }

  void addFavorite(AppUserFavourite newFav) {
    favorites.add(newFav);
    notifyListeners();
  }

  void removeFavorite(int favouriteId) {
    favorites.removeWhere((x) => x.id == favouriteId);
    notifyListeners();
  }
}
