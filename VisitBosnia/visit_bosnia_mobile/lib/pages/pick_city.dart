// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/main.dart';
import 'package:visit_bosnia_mobile/providers/city_provider.dart';

import '../components/navigation_drawer.dart';
import '../model/appUser/app_user.dart';
import '../model/city/city.dart';
import '../model/tourist_facility.dart';
import '../providers/appuser_provider.dart';
import 'city_facility.dart';

class PickCity extends StatelessWidget {
  PickCity(this.facility, {Key? key}) : super(key: key);

  String facility;
  late CityProvider _cityProvider;

  Future<List<City>?> loadCites() async {
    try {
      var cities = await _cityProvider.get(null);
      return cities;
    } catch (e) {
      return null;
    }
  }

  Widget titleSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      child: Row(
        children: [
          Column(
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: Row(children: <Widget>[
                  InkWell(
                    onTap: () =>
                        Navigator.of(navigatorKey.currentContext!).pop(),
                    child: Container(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.blue,
                        size: 24.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    ),
                  ),
                  Text(
                    'Pick a city ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  'Browse by cities',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gridItem(City city) {
    return InkWell(
        onTap: () {
          Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
              builder: (context) => CityFacility(facility, city.id!)));
        },
        child: Column(
          children: [
            Container(
                height: 140,
                width: 170,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.center,
                    image: MemoryImage(base64Decode(city.image!)),
                  ),
                )),
            Container(
              height: 40,
              width: 170,
              alignment: Alignment.center,
              child: Text(
                city.name!,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ));
  }

  _buildGrid() {
    var size = MediaQuery.of(navigatorKey.currentContext!).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2.9;
    final double itemWidth = (size.width) / 2;
    return FutureBuilder<List<City>?>(
        future: loadCites(),
        builder: (BuildContext context, AsyncSnapshot<List<City>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong...'),
              );
            } else {
              if (snapshot.data!.length > 0) {
                return GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                    controller: new ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: snapshot.data!.map((e) => _gridItem(e)).toList());
              } else {
                return Container(
                    padding: EdgeInsets.only(top: 60),
                    child: Text(
                      "No cities yet",
                      textAlign: TextAlign.center,
                    ));
              }
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    _cityProvider = context.read<CityProvider>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(29, 76, 120, 1),
        ),
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
            child: Column(children: [titleSection(), _buildGrid()])));
  }
}
