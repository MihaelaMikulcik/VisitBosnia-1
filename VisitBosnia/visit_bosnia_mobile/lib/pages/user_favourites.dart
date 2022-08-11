import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/appUserFavourite/app_user_favourite.dart';

import '../components/navigation_drawer.dart';
import '../model/appUser/app_user.dart';
import '../model/appUserFavourite/app_user_favourite_search_object.dart';
import '../model/id_navigation.dart';
import '../model/touristFacilityGallery/tourist_facility_gallery.dart';
import '../model/touristFacilityGallery/tourist_facility_gallery_search_object.dart';
import '../providers/appuser_favourite_provider.dart';
import '../providers/appuser_provider.dart';
import '../providers/tourist_facility_gallery_provider.dart';
import '../providers/tourist_facility_provider.dart';

class UserFavourites extends StatefulWidget {
  static const String routeName = "/userFavourite";

  UserFavourites({Key? key, required this.user}) : super(key: key);
  AppUser user;

  @override
  State<UserFavourites> createState() => _UserFavouritesState(user);
}

class _UserFavouritesState extends State<UserFavourites> {
  _UserFavouritesState(this.user);

  AppUser user;

  late AppUserProvider _appUserProvider;
  late AppUserFavouriteProvider _appUserFavouriteProvider;
  late TouristFacilityGalleryProvider _touristFacilityGalleryProvider;
  late TouristFacilityProvider _touristFacilityProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appUserProvider = context.read<AppUserProvider>();
    _appUserFavouriteProvider = context.read<AppUserFavouriteProvider>();
    _touristFacilityGalleryProvider =
        context.read<TouristFacilityGalleryProvider>();
    _touristFacilityProvider = context.read<TouristFacilityProvider>();
  }

  Future<List<AppUserFavourite>> loadAppUserFavourite() async {
    var search =
        AppUserFavouriteSearchObject(appUserId: _appUserProvider.userData.id);
    var favourites = await _appUserFavouriteProvider.get(search.toJson());
    return favourites;
  }

  Future<List<TouristFacilityGallery>> getGallery(int facilityId) async {
    var search = TouristFacilityGallerySearchObject(facilityId: facilityId);
    var gallery = await _touristFacilityGalleryProvider.get(search.toJson());
    return gallery;
  }

  Future<IdNavigation> getFacility(int facilityId) async {
    var facility = await _touristFacilityProvider.getById(facilityId);
    return facility;
  }

  Container imageContainer(TouristFacilityGallery gallery) {
    return Container(
        height: 130.0,
        width: 350.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                alignment: FractionalOffset.center,
                image: MemoryImage(
                  base64Decode(gallery.image!),
                )),
            borderRadius: BorderRadius.circular(20)));
  }

  _buildImage(int facilityId) {
    return FutureBuilder<List<TouristFacilityGallery>>(
        future: getGallery(facilityId),
        builder: (BuildContext context,
            AsyncSnapshot<List<TouristFacilityGallery>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
              // child: Text('Loading...'),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                // child: Text('${snapshot.error}'),
                child: Text('Something went wrong...'),
              );
            } else {
              if (snapshot.data!.length > 0) {
                return imageContainer(snapshot.data!.first);
              } else {
                return Container(
                  height: 130.0,
                  width: 350.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: FractionalOffset.center,
                        image: AssetImage("assets/images/location.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  // child: imageFromBase64String(gallery.image!),
                );
              }
            }
          }
        });
  }

  _buildText(int facilityId) {
    return FutureBuilder<IdNavigation>(
        future: getFacility(facilityId),
        builder: (BuildContext context, AsyncSnapshot<IdNavigation> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
              // child: Text('Loading...'),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                // child: Text('${snapshot.error}'),
                child: Text('Something went wrong...'),
              );
            } else {
              return Row(children: [
                Container(
                  padding: EdgeInsets.only(left: 50, bottom: 10),
                  child: Text(
                    snapshot.data!.name! + ", " + snapshot.data!.city!.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 17),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child:
                      Image.asset("assets/images/black_favourite_location.png"),
                )
              ]);
            }
          }
        });
  }

  Widget _FavouriteCard(AppUserFavourite favourite) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned(
              child: Container(
                width: 350.0,
                height: 180,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildText(favourite.touristFacilityId!),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), //color of shadow
                      spreadRadius: 5, //spread radius
                      blurRadius: 7, // blur radius
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: _buildImage(favourite.touristFacilityId!),
            ),
            Positioned(
              child: Container(
                  height: 30,
                  width: 30,
                  child: Image.asset("assets/images/heart-icon.png")),
              top: 10,
              right: 23,
            ),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }

  _buildFavourites() {
    return FutureBuilder<List<AppUserFavourite>>(
        future: loadAppUserFavourite(),
        builder: (BuildContext context,
            AsyncSnapshot<List<AppUserFavourite>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
              // child: Text('Loading...'),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                // child: Text('${snapshot.error}'),
                child: Text('Something went wrong...'),
              );
            } else {
              if (snapshot.data!.length > 0) {
                return Column(
                    children:
                        snapshot.data!.map((e) => _FavouriteCard(e)).toList());
              } else {
                return Container(
                    padding: EdgeInsets.only(top: 60),
                    child: ListView(children: [
                      Container(
                          padding: EdgeInsets.only(bottom: 20),
                          height: 90,
                          width: 90,
                          child: Image.asset("assets/images/heart2-icon.png")),
                      Text(
                        "No favorites yet",
                        textAlign: TextAlign.center,
                      )
                    ]));
              }
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(29, 76, 120, 1),
            ),
            drawer: NavigationDrawer(),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(children: [
                      titleSection(),
                      Container(child: _buildFavourites())
                    ])))));
  }

  Widget titleSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*2*/
                Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.only(left: 120),
                      child: Row(children: <Widget>[
                        Text(
                          'Favourites ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Container(
                            width: 30,
                            height: 30,
                            child: Image.asset("assets/images/heart-icon.png"))
                      ]),
                    )),
                Text(
                  'Places you liked the most',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
