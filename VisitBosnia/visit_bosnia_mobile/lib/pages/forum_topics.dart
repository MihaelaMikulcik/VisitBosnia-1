import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/post/post_insert_request.dart';
import 'package:visit_bosnia_mobile/model/post/post_search_object.dart';
import 'package:visit_bosnia_mobile/pages/post.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';
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
  // late AppUserProvider _appUserProvider;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Forum forum;
  String? search = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postProvider = context.read<PostProvider>();
  }

  Future<String> _numberOfReplies(int postId) async {
    try {
      var repliesNumber = await _postProvider.getNumberOfReplies(postId);
      return repliesNumber.toString();
    } catch (e) {
      return "error";
    }
  }

  Future<List<Post>?> GetData() async {
    try {
      PostSearchObject searchObj =
          PostSearchObject(forumId: forum.id, includeAppUser: true);
      if (search != "") {
        searchObj.title = search;
      }
      var tempData = await _postProvider.get(searchObj.toJson());
      return tempData;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // _appUserProvider = context.read<AppUserProvider>();
    // _postProvider = context.watch<PostProvider>();

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
                ),
                Center(
                  child: Text(
                    forum.title!,
                    style: const TextStyle(
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
                    padding: const EdgeInsets.all(10),
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
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("+ Create new post"),
                            InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: Icon(Icons.close))
                          ],
                        ),
                        content: buildCreateDialog()));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 15.0, right: 15.0),
                width: 100,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 3,
                          color: Color.fromARGB(255, 63, 62, 62))
                    ],
                    color: const Color.fromARGB(255, 217, 217, 217),
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "+ New post",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
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

  Widget buildCreateDialog() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _txtTitle(),
          _txtContent(),
          // const SizedBox(
          //   height: 5,
          // ),
          MaterialButton(
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                PostInsertRequest request = PostInsertRequest(
                    forumId: forum.id,
                    appUserId: AppUserProvider.userData.id,
                    title: _titleController.text,
                    content: _contentController.text,
                    createdTime: DateTime.now().toIso8601String());
                try {
                  await _postProvider.insert(request);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Something went wrong...",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      duration: const Duration(seconds: 2),
                      backgroundColor: const Color.fromARGB(255, 165, 46, 37)));
                }
                _titleController.clear();
                _contentController.clear();
                Navigator.pop(context);
              }
            },
            minWidth: 230,
            color: const Color.fromRGBO(29, 76, 120, 1),
            textColor: Colors.white,
            child: const Text(
              "Create post",
            ),
          ),
        ],
      ),
    );
  }

  removePost(topic) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Please Confirm'),
              content: const Text('Are you sure you want to delete post?'),
              actions: [
                TextButton(
                    onPressed: () async {
                      try {
                        await _postProvider.delete(topic.id!);
                        setState(() {});
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Something went wrong...",
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.white),
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor:
                                const Color.fromARGB(255, 165, 46, 37)));
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'))
              ],
            ));
  }

  Widget _txtContent() {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "";
          }
          return null;
        },
        controller: _contentController,
        keyboardType: TextInputType.text,
        minLines: 3,
        maxLines: 3,
        decoration: const InputDecoration(
            errorStyle: TextStyle(height: 0),
            hintText: "Write your post here...",
            focusedErrorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))));
  }

  Widget _txtTitle() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        }
        return null;
      },
      controller: _titleController,
      decoration: const InputDecoration(
          errorStyle: TextStyle(height: 0),
          hintText: "Title",
          contentPadding: EdgeInsets.all(10),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }

  Widget postWidget(Post post) {
    // var number;
    // _numberOfReplies(post.id!).then((value) => number = value);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ForumPost(post)));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 217, 217, 217),
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
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                // Padding(
                //     padding: EdgeInsets.only(left: 10),
                //     child: _buildReplies(post.id!)),

                Consumer<PostProvider>(builder: ((context, value, child) {
                  return Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: _buildReplies(post.id!));
                })),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppUserProvider.userData.id == post.appUserId
                    ? InkWell(
                        onTap: () => removePost(post),
                        child: Icon(Icons.delete_outline))
                    : Container(),
                SizedBox(
                  // width: double.infinity,
                  child: Text(
                    formatStringDate(
                      post.createdTime!,
                      'yMd',
                    ),
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 133, 128, 128),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReplies(int postId) {
    return FutureBuilder(
        future: _numberOfReplies(postId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 1,
                ));
          } else if (snapshot.hasData) {
            return Text(snapshot.data,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
          } else {
            return Text('error',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
          }
        });
  }

  Widget _buildPostsList() {
    return FutureBuilder<List<Post>?>(
        future: GetData(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>?> snapshot) {
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
                  children: snapshot.data!.map((e) => postWidget(e)).toList(),
                );
              } else {
                return SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Sorry, there are no topics for this forum yet!",
                        textAlign: TextAlign.center,
                      ),
                    ));
              }
            }
          }
        });
  }
}
