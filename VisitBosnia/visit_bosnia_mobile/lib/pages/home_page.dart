import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';
import 'package:visit_bosnia_mobile/model/appUserFavourite/app_user_favourite.dart';
import 'package:visit_bosnia_mobile/model/appUserFavourite/app_user_favourite_search_object.dart';
import 'package:visit_bosnia_mobile/model/attractions/attraction.dart';
import 'package:visit_bosnia_mobile/model/events/event_search_object.dart';
import 'package:visit_bosnia_mobile/model/touristFacilityGallery/tourist_facility_gallery.dart';
import 'package:visit_bosnia_mobile/model/touristFacilityGallery/tourist_facility_gallery_search_object.dart';
import 'package:visit_bosnia_mobile/pages/attraction_details.dart';
import 'package:visit_bosnia_mobile/pages/event_details.dart';
import 'package:visit_bosnia_mobile/pages/event_details2.dart';
import 'package:visit_bosnia_mobile/pages/pick_city.dart';
import 'package:visit_bosnia_mobile/providers/appuser_favourite_provider.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';
import 'package:visit_bosnia_mobile/providers/attraction_provider.dart';
import 'package:visit_bosnia_mobile/providers/category_provider.dart';
import 'package:visit_bosnia_mobile/providers/event_provider.dart';
import 'package:visit_bosnia_mobile/providers/category_provider.dart';
import 'package:visit_bosnia_mobile/providers/tourist_facility_gallery_provider.dart';
import 'dart:convert';
import '../components/navigation_drawer.dart';
import '../model/attractions/attraction_search_object.dart';
import '../model/category.dart';
import '../model/events/event.dart';
import '../utils/util.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "/homepage";

  Homepage({Key? key, required this.user}) : super(key: key);
  AppUser user;

  @override
  State<Homepage> createState() => _HomepageState(user);
}

class _HomepageState extends State<Homepage> {
  _HomepageState(this.user);
  // late EventProvider _eventProvider;
  // late AttractionProvider _attractionProvider;
  late TouristFacilityGalleryProvider _touristFacilityGalleryProvider;
  late AppUserProvider _appUserProvider;
  late CategoryProvider _categoryProvider;
  late AppUserFavouriteProvider _appUserFavouriteProvider;

  List<AppUserFavourite> userFavourite = [];

  AppUser user;
  int selectedCategory = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _eventProvider = context.read<EventProvider>();
    // _attractionProvider = context.read<AttractionProvider>();
    _touristFacilityGalleryProvider =
        context.read<TouristFacilityGalleryProvider>();
    _appUserProvider = context.read<AppUserProvider>();
    _categoryProvider = context.read<CategoryProvider>();
    _appUserFavouriteProvider = context.read<AppUserFavouriteProvider>();
    loadAppUserFavourite();
  }

  Future<List<Event>> loadEvents() async {
    // var search = EventSearchObject(
    //     includeAgency: true,
    //     includeAgencyMember: true,
    //     includeIdNavigation: true);
    // if (selectedCategory != 0) {
    //   search.categoryId = selectedCategory;
    // }
    var events = await _appUserProvider.recommendEvents(
        AppUserProvider.userData.id!, selectedCategory);
    return events;
  }

  Future<List<Attraction>> loadAttractions() async {
    // var search = AttractionSearchObject(includeIdNavigation: true);
    // if (selectedCategory != 0) {
    //   search.categoryId = selectedCategory;
    // }
    // var attractions = await _attractionProvider.get(search.toJson());
    var attractions = await _appUserProvider.recommendAttractions(
        AppUserProvider.userData.id!, selectedCategory);

    return attractions;
  }

  Future<List<Category>> loadCategories() async {
    var categories = await _categoryProvider.get(null);
    return categories;
  }

  Future loadAppUserFavourite() async {
    var search =
        AppUserFavouriteSearchObject(appUserId: AppUserProvider.userData.id);
    var favourites = await _appUserFavouriteProvider.get(search.toJson());
    setState(() {
      userFavourite = favourites;
    });
  }

  Future<List<TouristFacilityGallery>> getGallery(int facilityId) async {
    var search = TouristFacilityGallerySearchObject(facilityId: facilityId);
    var gallery = await _touristFacilityGalleryProvider.get(search.toJson());
    return gallery;
  }

  _buildImage(int facilityId) {
    return FutureBuilder<List<TouristFacilityGallery>>(
        future: getGallery(facilityId),
        builder: (BuildContext context,
            AsyncSnapshot<List<TouristFacilityGallery>> snapshot) {
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

  Container imageContainer(TouristFacilityGallery gallery) {
    return Container(
      height: 220,
      width: 150,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: const ColorFilter.mode(
              Color.fromARGB(66, 77, 76, 76),
              BlendMode.darken,
            ),
            image: MemoryImage(base64Decode(gallery.image!)),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20)),
      // child: imageFromBase64String(gallery.image!),
    );
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
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Column(children: [
              titleSection(),
              Container(
                // width: 340,
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.only(top: 15, bottom: 20, right: 30, left: 10),
                child: _buildDropDown(),
              ),
              SizedBox(
                width: double.infinity,
                child: Text("Attractions",
                    style:
                        TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Container(
                height: 220,
                child: _buildAttractions(),
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding:
                      const EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PickCity("Attraction")));
                        },
                        child: Text(
                          "View all",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 102, 101, 101)),
                        ),
                      ),
                      Icon(Icons.arrow_forward,
                          color: Color.fromARGB(255, 102, 101, 101))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text("Events",
                    style:
                        TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Container(
                height: 220,
                child: _buildEvents(),
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding:
                      const EdgeInsets.only(top: 10.0, right: 10.0, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PickCity("Event")));
                        },
                        child: Text(
                          "View all",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 102, 101, 101)),
                        ),
                      ),
                      Icon(Icons.arrow_forward,
                          color: Color.fromARGB(255, 102, 101, 101))
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _eventCard(Event event) {
    var contain =
        userFavourite.where((element) => element.touristFacilityId == event.id);
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EventDetails2(event)));
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildImage(event.id!),
            Positioned(
              child: Text(
                event.idNavigation!.name!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17),
              ),
              bottom: 10,
              left: 10,
              right: 10,
            ),
            Positioned(
              child: Container(
                height: 30,
                width: 30,
                child: contain.length > 0
                    ? Image.asset("assets/images/heart-icon.png")
                    : null,
              ),
              top: 10,
              right: 25,
            )
          ],
        ));
  }

  Widget _attractionCard(Attraction attraction) {
    var contain = userFavourite
        .where((element) => element.touristFacilityId == attraction.id);
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AttractionDetails(attraction)));
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildImage(attraction.id!),
            Positioned(
              child: Text(
                attraction.idNavigation!.name!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17),
              ),
              bottom: 10,
              left: 10,
              right: 10,
            ),
            Positioned(
              child: Container(
                height: 30,
                width: 30,
                child: contain.length > 0
                    ? Image.asset("assets/images/heart-icon.png")
                    : null,
              ),
              top: 10,
              right: 25,
            )
          ],
        ));
  }

  _buildAttractions() {
    return FutureBuilder<List<Attraction>>(
        future: loadAttractions(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Attraction>> snapshot) {
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
                return ListView(
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  children:
                      snapshot.data!.map((e) => _attractionCard(e)).toList(),
                );
              } else {
                return Container(
                    padding: EdgeInsets.only(top: 60),
                    child: ListView(children: [
                      Container(
                          padding: EdgeInsets.only(bottom: 20),
                          height: 90,
                          width: 90,
                          child: Image.asset("assets/images/sad.jpg")),
                      Text(
                        "Oops ... No attractions to show",
                        textAlign: TextAlign.center,
                      )
                    ]));
              }
            }
          }
        });
  }

  _buildEvents() {
    return FutureBuilder<List<Event>>(
        future: loadEvents(),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
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
                return ListView(
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  children: snapshot.data!.map((e) => _eventCard(e)).toList(),
                );
              } else {
                return Container(
                    padding: EdgeInsets.only(top: 60),
                    child: ListView(children: [
                      Container(
                          padding: EdgeInsets.only(bottom: 20),
                          height: 90,
                          width: 90,
                          child: Image.asset("assets/images/sad.jpg")),
                      Text(
                        "Oops ... No events to show",
                        textAlign: TextAlign.center,
                      )
                    ]));
              }
            }
          }
        });
  }

  DropdownMenuItem<int> _dropDownItem(Category category) {
    return DropdownMenuItem<int>(
      child: Text(
        category.name!,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Color.fromARGB(255, 92, 88, 88)),
      ),
      value: category.id,
    );
  }

  void dropdownCallback(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {
        selectedCategory = selectedValue;
      });
    }
  }

  _buildDropDown() {
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
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: DropdownButton2(
                  // dropdownDecoration: ,
                  isExpanded: true,
                  onChanged: dropdownCallback,
                  hint: Row(
                    children: const [
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'Choose category',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 90, 90, 85),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  iconSize: 40,
                  dropdownMaxHeight: 200,
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  items: snapshot.data!.map((e) => _dropDownItem(e)).toList(),
                  value: selectedCategory == 0 ? null : selectedCategory,
                  dropdownDecoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(14),
                    color: Color.fromARGB(255, 205, 210, 215),
                  ),
                  buttonDecoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 2,
                          color: Color.fromARGB(255, 63, 62, 62))
                    ],
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(
                    //     color: Colors.black26,
                    //     ),
                    color: Color.fromARGB(255, 205, 210, 215),
                  ),
                ),
              );
              // return Container(
              //     // width: 250,
              //     width: MediaQuery.of(context).size.width,
              //     height: 40,
              //     padding: EdgeInsets.only(left: 20, right: 20),
              //     decoration: BoxDecoration(
              //         boxShadow: const [
              //           BoxShadow(
              //               offset: Offset(0, 2),
              //               blurRadius: 2,
              //               color: Color.fromARGB(255, 63, 62, 62))
              //         ],
              //         color: Color.fromARGB(255, 205, 210, 215),
              //         // border: Border.all(color: Colors.black),
              //         borderRadius: BorderRadius.circular(12)),
              //     child: DropdownButtonHideUnderline(
              //         child: DropdownButton<int>(
              //       dropdownColor: Color.fromARGB(255, 205, 210, 215),
              //       items: snapshot.data!.map((e) => _dropDownItem(e)).toList(),
              //       onChanged: dropdownCallback,
              //       iconSize: 40.0,
              //       isExpanded: true,
              //       value: selectedCategory == 0 ? null : selectedCategory,
              //       hint: Text(
              //         "Choose category",
              //       ),
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 20,
              //       ),
              //     )));
            }
          }
        });
  }

  Widget titleSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(children: <Widget>[
                    Text(
                      'Hi, ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Text(AppUserProvider.userData.firstName! + "!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ))
                  ]),
                ),
                Text(
                  'What to visit next?',
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
