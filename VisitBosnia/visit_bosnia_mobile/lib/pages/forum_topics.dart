import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/post/post_search_object.dart';
import 'package:visit_bosnia_mobile/providers/post_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../components/navigation_drawer.dart';
import '../model/forum/forum.dart';
import '../model/post/post.dart';

class ForumTopics extends StatefulWidget {
  ForumTopics(this.forum, {Key? key}) : super(key: key);
  Forum forum;

  @override
  State<ForumTopics> createState() => _ForumTopicsState(forum);
}

class _ForumTopicsState extends State<ForumTopics> {
  _ForumTopicsState(this.forum);
  late PostProvider _postProvider;

  Forum forum;
  String? search = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postProvider = context.read<PostProvider>();
  }

  Future<List<Post>> GetData() async {
    PostSearchObject searchObj = PostSearchObject(forumId: forum.id);
    if (search != "") {
      searchObj.title = search;
    }
    var tempData = await _postProvider.get(searchObj.toJson());
    return tempData;
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.memory(
                    base64Decode(forum.city!.image!),
                    gaplessPlayback: true,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.5),
                    colorBlendMode: BlendMode.darken,
                  ),
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  // // image: imageFromBase64String(forum.city!.image!).image,
                  // image: Image.memory(
                  //   base64Decode(forum.city!.image!),
                  //   gaplessPlayback: true,
                  // ).image,
                  // fit: BoxFit.cover,
                  // colorFilter: ColorFilter.mode(
                  //     Colors.black.withOpacity(0.5), BlendMode.darken),
                ),
                Center(
                  child: Text(
                    forum.title!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
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
                          hintText: "Search topics...",
                          suffixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8)),
                      onChanged: (value) {
                        print(value);
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
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(bottom: 15.0, right: 15.0),
                width: 100,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          color: Color.fromARGB(255, 63, 62, 62))
                    ],
                    color: Color.fromARGB(255, 217, 217, 217),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "+ New topic",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1.3))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Topic",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Replies",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            child: _buildPostsList(),
          )
        ],
      ),
    );
  }

  Widget postWidget(Post post) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(left: 20, top: 10, right: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 217, 217, 217),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 2,
                color: Color.fromARGB(255, 63, 62, 62))
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(post.title!,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Text("3",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Text(
                formatStringDate(
                  post.createdTime!,
                  'yMd',
                ),
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 133, 128, 128),
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPostsList() {
    return FutureBuilder<List<Post>>(
        future: GetData(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
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
              return ListView(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                children: snapshot.data!.map((e) => postWidget(e)).toList(),
              );
            }
          }
        });
  }
}
