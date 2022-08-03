import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/components/navigation_drawer.dart';
import 'package:visit_bosnia_mobile/providers/city_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../model/city/city.dart';

class Forum extends StatefulWidget {
  const Forum({Key? key}) : super(key: key);

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  late CityProvider _cityProvider;
  // List<City> _cities = [];
  String? search = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cityProvider = context.read<CityProvider>();
  }

  Future<List<City>> GetData() async {
    List<City> cities;
    if (search != "") {
      cities = await _cityProvider.get({'Name': search});
    } else {
      cities = await _cityProvider.get();
    }
    return cities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(29, 76, 120, 1),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                    image: AssetImage("assets/images/forum.jpg"),
                    fit: BoxFit.cover,
                  ))),
                  const Positioned(
                      top: 25,
                      left: 25,
                      child: Text(
                        "Forum",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      )),
                  Positioned(
                    bottom: -23,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                      ),
                      padding: EdgeInsets.all(10),
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 10,
                                color: Colors.grey)
                          ]),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search cities...",
                            suffixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8)),
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            search = value;
                          });
                          // GetData(value);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              // height: 300,
              child: _buildCityList(),
            )
          ],
        ));
  }

  Widget _buildCityList() {
    return FutureBuilder<List<City>>(
        future: GetData(),
        builder: (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
              // child: Text('Loading...'),
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                // child: Text('${snapshot.error}'),
                child: Text('Something went wrong...'),
              );
            } else {
              return ListView(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                children: snapshot.data!.map((e) => cityWidget(e)).toList(),
              );
            }
          }
        });
  }

  Widget cityWidget(City city) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 85,
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.only(left: 30, bottom: 13, right: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: imageFromBase64String(city.image!).image,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: Text(
          city.name!,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
