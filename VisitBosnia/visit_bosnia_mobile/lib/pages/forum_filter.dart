import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/components/navigation_drawer.dart';
import 'package:visit_bosnia_mobile/model/forum/forum.dart';
import 'package:visit_bosnia_mobile/model/forum/forum_search_object.dart';
import 'package:visit_bosnia_mobile/pages/forum_topics.dart';
import 'package:visit_bosnia_mobile/providers/city_provider.dart';
import 'package:visit_bosnia_mobile/providers/forum_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../model/city/city.dart';

class ForumFilter extends StatefulWidget {
  const ForumFilter({Key? key}) : super(key: key);

  @override
  State<ForumFilter> createState() => _ForumFilterState();
}

class _ForumFilterState extends State<ForumFilter> {
  late ForumProvider _forumProvider;
  String? search = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _forumProvider = context.read<ForumProvider>();
  }

  Future<List<Forum>?> GetData() async {
    try {
      List<Forum> forums;
      ForumSearchObject searchObj = ForumSearchObject(includeCity: true);
      if (search != "") {
        searchObj.title = search;
      }
      forums = await _forumProvider.get(searchObj.toJson());
      return forums;
    } catch (e) {
      return null;
    }
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
                          // print(value);
                          setState(() {
                            search = value;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: _buildForumList(),
            )
          ],
        ));
  }

  Widget _buildForumList() {
    return FutureBuilder<List<Forum>?>(
        future: GetData(),
        builder: (BuildContext context, AsyncSnapshot<List<Forum>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong...'),
              );
            } else {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  children: snapshot.data!.map((e) => forumWidget(e)).toList(),
                );
              } else {
                return SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "There are currently no active forums",
                        textAlign: TextAlign.center,
                      ),
                    ));
              }
            }
          }
        });
  }

  Widget forumWidget(Forum forum) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ForumTopics(forum)));
      },
      child: Container(
        height: 85,
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.only(left: 30, bottom: 13, right: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: imageFromBase64String(forum.city!.image!).image,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.darken),
          ),
        ),
        child: Text(
          forum.city!.name!,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
