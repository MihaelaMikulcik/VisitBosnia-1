import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/appUserFavourite/app_user_favourite.dart';

import '../components/navigation_drawer.dart';
import '../model/appUser/app_user.dart';
import '../model/appUserFavourite/app_user_favourite_search_object.dart';
import '../model/attractions/attraction.dart';
import '../model/events/event.dart';
import '../model/tourist_facility.dart';
import '../model/touristFacilityGallery/tourist_facility_gallery.dart';
import '../model/touristFacilityGallery/tourist_facility_gallery_search_object.dart';
import '../providers/appuser_favourite_provider.dart';
import '../providers/appuser_provider.dart';
import '../providers/attraction_provider.dart';
import '../providers/event_provider.dart';
import '../providers/tourist_facility_gallery_provider.dart';
import '../providers/tourist_facility_provider.dart';
import 'attraction_details.dart';
import 'event_details2.dart';

class UserFavourites extends StatefulWidget {
  static const String routeName = "/userFavourite";

  UserFavourites({Key? key}) : super(key: key);

  @override
  State<UserFavourites> createState() => _UserFavouritesState();
}

class _UserFavouritesState extends State<UserFavourites> {
  _UserFavouritesState();

  late List<int> attractionIds = [];

  // late AppUserProvider _appUserProvider;
  late AppUserFavouriteProvider _appUserFavouriteProvider;
  late TouristFacilityGalleryProvider _touristFacilityGalleryProvider;
  late TouristFacilityProvider _touristFacilityProvider;
  late AttractionProvider _attractionProvider;
  late EventProvider _eventProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _appUserProvider = context.read<AppUserProvider>();
    _appUserFavouriteProvider = context.read<AppUserFavouriteProvider>();
    _touristFacilityGalleryProvider =
        context.read<TouristFacilityGalleryProvider>();
    _attractionProvider = context.read<AttractionProvider>();
    _eventProvider = context.read<EventProvider>();
    _touristFacilityProvider = context.read<TouristFacilityProvider>();
  }

  // Future<List<AppUserFavourite>> loadAppUserFavourite() async {
  //   var search =
  //       AppUserFavouriteSearchObject(appUserId: AppUserProvider.userData.id);
  //   var favourites = await _appUserFavouriteProvider.get(search.toJson());
  //   var attractions = await _attractionProvider.get(null);
  //   for (var atr in attractions) {
  //     attractionIds.add(atr.id!);
  //   }
  //   return favourites;
  // }

  Future loadIds() async {
    try {
      var attractions = await _attractionProvider.get(null);
      for (var atr in attractions) {
        attractionIds.add(atr.id!);
      }
    } catch (e) {
      attractionIds = [];
    }
  }
  // Future<List<TouristFacilityGallery>> getGallery(int facilityId) async {
  //   var search = TouristFacilityGallerySearchObject(facilityId: facilityId);
  //   var gallery = await _touristFacilityGalleryProvider.get(search.toJson());
  //   return gallery;
  // }

  Future<String?> getImage(int facilityId) async {
    try {
      var search = TouristFacilityGallerySearchObject(
          facilityId: facilityId, isThumbnail: true);
      var image = await _touristFacilityGalleryProvider.get(search.toJson());
      if (image.isNotEmpty) {
        return image.first.image!;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Attraction> loadAttraction(int id) async {
    var obj = await _attractionProvider.getById(id);
    return obj;
  }

  Future<Event> loadEvent(int id) async {
    var obj = await _eventProvider.getById(id);
    return obj;
  }

  Future<TouristFacility> getFacility(int facilityId) async {
    var facility = await _touristFacilityProvider.getById(facilityId);
    return facility;
  }

  Widget imageContainer(String image) {
    return Container(
        height: 120.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                alignment: FractionalOffset.center,
                image: MemoryImage(
                  base64Decode(image),
                )),
            borderRadius: BorderRadius.circular(20)));
  }

  _buildImage(int facilityId) {
    return FutureBuilder<String?>(
        future: getImage(facilityId),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 120.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 205, 210, 215),
              ),

              child: Center(child: CircularProgressIndicator()),
              //   // child: Text('Loading...'),
            );
            // return Center(
            //   child: CircularProgressIndicator(),
            //   // child: Text('Loading...'),
            // );
          } else {
            if (snapshot.hasError) {
              return Center(
                // child: Text('${snapshot.error}'),
                child: Text('Something went wrong...'),
              );
            } else {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return imageContainer(snapshot.data!);
              } else {
                return Container(
                  height: 130.0,
                  width: MediaQuery.of(context).size.width,
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
    return FutureBuilder<TouristFacility>(
        future: getFacility(facilityId),
        builder:
            (BuildContext context, AsyncSnapshot<TouristFacility> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              // width: 40,
              // height: 50,
              child: Text(
                "...",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17),
              ),
              padding: EdgeInsets.only(bottom: 10),
              // child: Image.asset("assets/images/black_favourite_location.png"),
            );
            // return Center(
            //   child: CircularProgressIndicator(),
            //   // child: Text('Loading...'),
            // );
          } else {
            if (snapshot.hasError) {
              return Center(
                // child: Text('${snapshot.error}'),
                child: Text('Something went wrong...'),
              );
            } else {
              return Row(children: [
                Expanded(
                  // padding: EdgeInsets.only(left: 50, bottom: 10),
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
                  padding: EdgeInsets.only(bottom: 10),
                  child:
                      Image.asset("assets/images/black_favourite_location.png"),
                )
              ]);
            }
          }
        });
  }

  Widget _FavouriteCard(AppUserFavourite favourite) {
    return InkWell(
        onTap: () async {
          if (attractionIds.contains(favourite.touristFacilityId!)) {
            var obj = await loadAttraction(favourite.touristFacilityId!);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AttractionDetails(obj.id!)));
          } else {
            var obj = await loadEvent(favourite.touristFacilityId!);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EventDetails2(obj.id!)));
          }
        },
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 170,
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
        ));
  }

  _buildFavourites() {
    return FutureBuilder(
        future: loadIds(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return Container(
            //   padding: EdgeInsets.only(top: 60),
            //   child: CircularProgressIndicator(),
            // );
            return Center(
              child: CircularProgressIndicator(),
              // child: Text('Loading...'),
            );
          } else {
            return (_appUserFavouriteProvider.favorites.isNotEmpty &&
                    _appUserFavouriteProvider.favorites.length > 0)
                ? Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                        children: _appUserFavouriteProvider.favorites
                            .map((e) => _FavouriteCard(e))
                            .toList()),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
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
        });
  }

  // _buildFavourites() {
  //   return FutureBuilder<List<AppUserFavourite>>(
  //       future: loadAppUserFavourite(),
  //       builder: (BuildContext context,
  //           AsyncSnapshot<List<AppUserFavourite>> snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           // return Container(
  //           //   padding: EdgeInsets.only(top: 60),
  //           //   child: CircularProgressIndicator(),
  //           // );
  //           return Center(
  //             child: CircularProgressIndicator(),
  //             // child: Text('Loading...'),
  //           );
  //         } else {
  //           if (snapshot.hasError) {
  //             return Center(
  //               // child: Text('${snapshot.error}'),
  //               child: Text('Something went wrong...'),
  //             );
  //           } else {
  //             if (snapshot.data!.length > 0) {
  //               return Column(
  //                   children:
  //                       snapshot.data!.map((e) => _FavouriteCard(e)).toList());
  //             } else {
  //               return Container(
  //                   padding: EdgeInsets.only(top: 60),
  //                   child: ListView(children: [
  //                     Container(
  //                         padding: EdgeInsets.only(bottom: 20),
  //                         height: 90,
  //                         width: 90,
  //                         child: Image.asset("assets/images/heart2-icon.png")),
  //                     Text(
  //                       "No favorites yet",
  //                       textAlign: TextAlign.center,
  //                     )
  //                   ]));
  //             }
  //           }
  //         }
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(29, 76, 120, 1),
        ),
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(children: [
                  titleSection(),
                  Divider(),
                  Container(
                      // height: MediaQuery.of(context).size.height,
                      child: _buildFavourites())
                ]))));
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
                      padding: const EdgeInsets.only(left: 110),
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
