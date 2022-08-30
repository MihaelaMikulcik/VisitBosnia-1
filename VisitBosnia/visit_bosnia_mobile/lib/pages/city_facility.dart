import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/events/event.dart';
import 'package:visit_bosnia_mobile/providers/attraction_provider.dart';
import 'package:visit_bosnia_mobile/providers/category_provider.dart';
import 'package:visit_bosnia_mobile/providers/city_provider.dart';

import '../components/navigation_drawer.dart';
import '../model/appUser/app_user.dart';
import '../model/attractions/attraction.dart';
import '../model/attractions/attraction_search_object.dart';
import '../model/category.dart';
import '../model/city/city.dart';
import '../model/events/event_search_object.dart';
import '../model/tourist_facility.dart';
import '../model/touristFacilityGallery/tourist_facility_gallery.dart';
import '../model/touristFacilityGallery/tourist_facility_gallery_search_object.dart';
import '../providers/appuser_provider.dart';
import '../providers/event_provider.dart';
import '../providers/tourist_facility_gallery_provider.dart';
import 'attraction_details.dart';
import 'event_details2.dart';

class CityFacility extends StatefulWidget {
  static const String routeName = "/pickCity";

  CityFacility(this.facility, this.cityId, {Key? key}) : super(key: key);

  String facility;
  int cityId;

  @override
  State<CityFacility> createState() => _CityFacilityState(facility, cityId);
}

class _CityFacilityState extends State<CityFacility> {
  _CityFacilityState(this.facility, this.cityId);

  String facility;
  int cityId;

  // late AppUserProvider _appUserProvider;
  late CityProvider _cityProvider;
  late AttractionProvider _attractionProvider;
  late EventProvider _eventProvider;
  late CategoryProvider _categoryProvider;
  late City cityObj;
  late TouristFacilityGalleryProvider _touristFacilityGalleryProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _appUserProvider = context.read<AppUserProvider>();
    _cityProvider = context.read<CityProvider>();
    _eventProvider = context.read<EventProvider>();
    _attractionProvider = context.read<AttractionProvider>();
    _categoryProvider = context.read<CategoryProvider>();
    _touristFacilityGalleryProvider =
        context.read<TouristFacilityGalleryProvider>();
  }

  Future<City?> loadCity() async {
    try {
      var object = await _cityProvider.getById(cityId);
      return object;
    } catch (e) {
      return null;
    }
  }

  // Future<List<TouristFacilityGallery>> getGallery(int facilityId) async {
  //   var search = TouristFacilityGallerySearchObject(facilityId: facilityId);
  //   var gallery = await _touristFacilityGalleryProvider.get(search.toJson());
  //   return gallery;
  // }

  Future<String?> getImage(int facilityId) async {
    var search = TouristFacilityGallerySearchObject(
        facilityId: facilityId, isThumbnail: true);
    try {
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

  // Future<List<dynamic>?> loadFacilites(int catId) async {
  //   try {
  //     if (facility == "Event") {
  //       var search = EventSearchObject(
  //         includeIdNavigation: true,
  //         includeAgency: true,
  //         includeAgencyMember: true,
  //       );
  //       search.cityId = cityId;
  //       search.categoryId = catId;
  //       var object = await _eventProvider.get(search.toJson());
  //       return object;
  //     } else {
  //       var search = AttractionSearchObject(includeIdNavigation: true);
  //       search.categoryId = catId;
  //       search.cityId = cityId;
  //       var object = await _attractionProvider.get(search.toJson());
  //       return object;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Future<List<dynamic>?> loadFacilites(int catId) async {
    try {
      if (facility == "Event") {
        var search = EventSearchObject(
          includeIdNavigation: true,
          // includeAgency: true,
          // includeAgencyMember: true,
        );
        search.cityId = cityId;
        search.categoryId = catId;
        var object = await _eventProvider.get(search.toJson());
        return object;
      } else {
        var search = AttractionSearchObject(includeIdNavigation: true);
        search.categoryId = catId;
        search.cityId = cityId;
        var object = await _attractionProvider.get(search.toJson());
        return object;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Category>?> loadCategories() async {
    try {
      var categories = await _categoryProvider.get(null);
      return categories;
    } catch (e) {
      return null;
    }
  }

  Widget titleSection(City city) {
    return Container(
      padding: const EdgeInsets.all(10),
      child:
          /*1*/
          Column(
        children: [
          /*2*/
          Container(
            child: Text(
              city.name!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Container(
            child: Text(
              "Browse " + facility + "s in " + city.name!,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 20,
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(29, 76, 120, 1),
        ),
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(top: 20), child: _buildCity())));
  }

  Container imageContainer(String image) {
    return Container(
      height: 220,
      width: 150,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(base64Decode(image)),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20)),
      // child: imageFromBase64String(gallery.image!),
    );
  }

  _buildCity() {
    return FutureBuilder<City?>(
        future: loadCity(),
        builder: (BuildContext context, AsyncSnapshot<City?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Container()
                // child: Text('Loading...'),
                );
          } else {
            if (snapshot.hasData) {
              return Column(
                  children: [titleSection(snapshot.data!), _buildCategory()]);
            } else {
              return Center(
                // child: Text('${snapshot.error}'),
                child: Text('Something went wrong...'),
              );
            }
          }
        });
  }

  _buildImage(int facilityId) {
    return FutureBuilder<String?>(
        future: getImage(facilityId),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 220,
              width: 150,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 205, 210, 215),
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(right: 15),
              child: Center(
                child: CircularProgressIndicator(),
                // child: Text('Loading...'),
              ),
            );
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
                  height: 220,
                  width: 150,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                      image: DecorationImage(
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

  Widget _buildCards(TouristFacility facility) {
    return InkWell(
        onTap: () {
          if (facility == "Event") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EventDetails2(facility.id!)));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AttractionDetails(facility.id!)));
          }
        },
        child: Stack(
          children: [
            _buildImage(facility.id!),
            Positioned(
              child: Center(
                child: Text(
                  facility.name!.length > 13
                      ? '${facility.name!.substring(0, 13)}...'
                      : facility.name!,
                  // object.idNavigation!.name!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              bottom: 5,
              left: 5,
            )
          ],
        ));
  }

  Widget _buildFacility(Category category) {
    return FutureBuilder<List<dynamic>?>(
        future: loadFacilites(category.id!),
        builder:
            (BuildContext context, AsyncSnapshot<List<dynamic>?> snapshot) {
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
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 20, left: 20),
                    child: Row(children: [
                      Text(
                        category.name!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: SizedBox(
                      height: 200,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: ScrollPhysics(),
                          children: (snapshot.data!
                              .map((e) => _buildCards(e.idNavigation))
                              .toList())),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 2,
                    ),
                  )
                ]);
              } else {
                return Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 20, left: 20),
                    child: Row(children: [
                      Text(
                        category.name!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ]),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "No facilites for this category yet",
                        textAlign: TextAlign.center,
                      )),
                  Divider(
                    thickness: 2,
                  )
                ]);
              }
            }
          }
        });
  }

  _buildCategory() {
    return FutureBuilder<List<Category>?>(
        future: loadCategories(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>?> snapshot) {
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
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Column(
                    children:
                        snapshot.data!.map((e) => _buildFacility(e)).toList());
              } else {
                return Container(
                    padding: EdgeInsets.only(top: 60),
                    child: Text(
                      "No categories yet",
                      textAlign: TextAlign.center,
                    ));
              }
            }
          }
        });
  }
}
