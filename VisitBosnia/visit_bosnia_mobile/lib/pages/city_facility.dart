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

  late AppUserProvider _appUserProvider;
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
    _appUserProvider = context.read<AppUserProvider>();
    _cityProvider = context.read<CityProvider>();
    _eventProvider = context.read<EventProvider>();
    _attractionProvider = context.read<AttractionProvider>();
    _categoryProvider = context.read<CategoryProvider>();
    _touristFacilityGalleryProvider =
        context.read<TouristFacilityGalleryProvider>();
  }

  Future<City> loadCity() async {
    var object = await _cityProvider.getById(cityId);
    return object;
  }

  Future<List<TouristFacilityGallery>> getGallery(int facilityId) async {
    var search = TouristFacilityGallerySearchObject(facilityId: facilityId);
    var gallery = await _touristFacilityGalleryProvider.get(search.toJson());
    return gallery;
  }

  Future<List<dynamic>> loadFacilites(int catId) async {
    if (facility == "Event") {
      var search = EventSearchObject(
        includeIdNavigation: true,
        includeAgency: true,
        includeAgencyMember: true,
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
  }

  Future<List<Category>> loadCategories() async {
    var categories = await _categoryProvider.get(null);
    return categories;
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

  Container imageContainer(TouristFacilityGallery gallery) {
    return Container(
      height: 220,
      width: 150,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(base64Decode(gallery.image!)),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20)),
      // child: imageFromBase64String(gallery.image!),
    );
  }

  _buildCity() {
    return FutureBuilder<City>(
        future: loadCity(),
        builder: (BuildContext context, AsyncSnapshot<City> snapshot) {
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
              return Column(
                  children: [titleSection(snapshot.data!), _buildCategory()]);
            }
          }
        });
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

  Widget _buildCards(dynamic object) {
    return InkWell(
        onTap: () {
          if (facility == "Event") {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EventDetails2(object)));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AttractionDetails(object)));
          }
        },
        child: Stack(
          children: [
            _buildImage(object.id!),
            Positioned(
              child: Center(
                child: Text(
                  object.idNavigation!.name!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              bottom: 5,
            )
          ],
        ));
  }

  Widget _buildFacility(Category category) {
    return FutureBuilder<List<dynamic>>(
        future: loadFacilites(category.id!),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
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
                              .map((e) => _buildCards(e))
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
    return FutureBuilder<List<Category>>(
        future: loadCategories(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
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
