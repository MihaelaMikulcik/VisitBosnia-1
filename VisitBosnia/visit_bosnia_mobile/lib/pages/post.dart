// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/post/post_insert_request.dart';
import 'package:visit_bosnia_mobile/model/post/post_search_object.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';
import 'package:visit_bosnia_mobile/providers/post_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../components/navigation_drawer.dart';
import '../model/appUser/app_user.dart';
import '../model/forum/forum.dart';
import '../model/post/post.dart';
import '../model/postReply/post_reply.dart';
import '../model/postReply/post_reply_insert_request.dart';
import '../model/postReply/post_reply_search_object.dart';
import '../model/roles/role.dart';
import '../model/roles/appuser_role_search_object.dart';
import '../providers/appuser_role_provider.dart';
import '../providers/post_reply_provider.dart';

class ForumPost extends StatefulWidget {
  ForumPost(this.forumPost, {Key? key}) : super(key: key);
  Post forumPost;

  @override
  State<ForumPost> createState() => _ForumPostState(forumPost);
}

class _ForumPostState extends State<ForumPost> {
  _ForumPostState(this.forumPost);

  late PostProvider _postProvider;
  late PostReplyProvider _postReplyProvider;
  late AppUserProvider _appUserProvider;
  late AppUserRoleProvider _appUserRoleProvider;

  final TextEditingController _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Post forumPost;
  String? search = "";

  var items = [
    'Newest first',
    'Oldest first',
  ];
  String dropdownvalue = 'Newest first';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postProvider = context.read<PostProvider>();
    _postReplyProvider = context.read<PostReplyProvider>();
    _appUserRoleProvider = context.read<AppUserRoleProvider>();
  }

  Future<List<PostReply>?> GetReply() async {
    try {
      PostReplySearchObject searchObj =
          PostReplySearchObject(postId: forumPost.id, includeAppUser: true);
      var tempData = await _postReplyProvider.get(searchObj.toJson());

      return tempData;
    } catch (e) {
      return null;
    }
  }

  Future<Role?> GetRole(int appUserId) async {
    try {
      AppUserRoleSearchObject searchObj =
          AppUserRoleSearchObject(appUserId: appUserId, includeRole: true);
      var tempData = await _appUserRoleProvider.get(searchObj.toJson());
      return tempData.first.role!;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _appUserProvider = context.read<AppUserProvider>();

    return Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(29, 76, 120, 1),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            _buildPost(),
            SizedBox(
              height: 20,
            ),
            _buildeReplies()
          ]),
        ));
  }

  Widget imageContainer(AppUser user) {
    if (user.image != "") {
      return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(base64Decode(user.image!)),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(30)));
    } else {
      return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/user3.jpg"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(30)));
    }
  }

  _buildPost() {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(offset: Offset(0, 5), blurRadius: 5, color: Colors.grey)
          ],
        ),
        child: Column(children: [
          Container(
              child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                imageContainer(forumPost.appUser!),
                Container(
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(forumPost.appUser!.userName!,
                        maxLines: 50,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  // )
                )
              ]),
            ),
            SizedBox(width: 10),
            Expanded(
                child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  forumPost.title!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  maxLines: 50,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )),
          ])),
          SizedBox(height: 25),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 10.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      forumPost.content!,
                      maxLines: 100,
                      overflow: TextOverflow.ellipsis,
                    )),
              )),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 10.0, bottom: 15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(formatStringDate(
                            forumPost.createdTime!,
                            'yMd',
                          ) +
                          ', ' +
                          getTime(forumPost.createdTime!))),
                  Container(
                    height: 35,
                    width: 90,
                    child: Center(
                        child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                      title: const Text("Write your reply"),
                                      content: buildCreateDialog()));
                            },
                            child: Text("Reply",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)))),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 216, 216, 216),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            color: Color.fromARGB(255, 90, 85, 85))
                      ],
                    ),
                  )
                ]),
          ),
        ]));
  }

  buidlFilter(int total) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Row(
        children: [
          Text(total.toString() + " replies",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(width: 20),
          Container(
            height: 30,
            width: 130,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 2,
                    color: Color.fromARGB(255, 63, 62, 62))
              ],
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 205, 210, 215),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 7.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildeReplies() {
    return FutureBuilder<List<PostReply>?>(
        future: GetReply(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PostReply>?> snapshot) {
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
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                if (dropdownvalue == 'Newest first') {
                  return Column(children: [
                    Container(
                      child: buidlFilter(snapshot.data!.length),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          children: snapshot.data!.reversed
                              .toList()
                              .map((e) => _buildReplyCard(e))
                              .toList(),
                        ))
                  ]);
                } else {
                  return Column(children: [
                    Container(
                      child: buidlFilter(snapshot.data!.length),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          children: snapshot.data!
                              .map((e) => _buildReplyCard(e))
                              .toList(),
                        ))
                  ]);
                }
              } else {
                return Container();
              }
            }
          }
        });
  }

  _buildeRole(int appUserId) {
    return FutureBuilder<Role?>(
        future: GetRole(appUserId),
        builder: (BuildContext context, AsyncSnapshot<Role?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong...'),
              );
            } else {
              if (snapshot.hasData && snapshot.data!.name! == "Agency") {
                return Row(children: [
                  Icon(
                    Icons.flag,
                    color: Colors.orange,
                    size: 24.0,
                  ),
                  Text(" Guide")
                ]);
              } else {
                return Container();
              }
            }
          }
        });
  }

  Widget _buildReplyCard(PostReply reply) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 205, 210, 215),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 3),
                  color: Color.fromARGB(255, 128, 129, 131),
                  blurRadius: 3,
                )
              ]),
          child: Column(children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: imageContainer(reply.appUser!),
                    ),
                    Container(
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(reply.appUser!.userName!,
                            maxLines: 50,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        reply.content!,
                        maxLines: 100,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: _buildeRole(reply.appUserId!),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              reply.appUserId! != AppUserProvider.userData.id!
                  ? Container()
                  : removeReply(reply),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formatStringDate(
                              reply.createdTime!,
                              'yMd',
                            ) +
                            ', ' +
                            getTime(reply.createdTime!),
                      ))),
            ])
          ])),
    );
  }

  Widget removeReply(PostReply reply) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text('Please Confirm'),
                      content:
                          const Text('Are you sure you want to delete reply?'),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              try {
                                await _postReplyProvider.delete(reply.id!);

                                setState(() {});
                                _postProvider.updateReplies(reply.postId!);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                          "Something went wrong...",
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.white),
                                        ),
                                        duration: const Duration(seconds: 2),
                                        backgroundColor: const Color.fromARGB(
                                            255, 165, 46, 37)));
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
          },
          child: Icon(
            Icons.delete_outlined,
            color: Colors.black,
            size: 22.0,
          ),
        ),
      ),
    );
  }

  Widget buildCreateDialog() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _txtContent(),
              const SizedBox(
                height: 5,
              ),
              MaterialButton(
                onPressed: () async {
                  final isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    PostReplyInsertRequest request = PostReplyInsertRequest(
                        postId: forumPost.id,
                        appUserId: AppUserProvider.userData.id,
                        content: _contentController.text,
                        createdTime: DateTime.now().toIso8601String());
                    try {
                      await _postReplyProvider.insert(request);
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
                    _contentController.clear();
                    Navigator.pop(context);
                    setState(() {});
                  }
                },
                minWidth: 230,
                color: const Color.fromRGBO(29, 76, 120, 1),
                textColor: Colors.white,
                child: const Text(
                  "Post reply",
                ),
              ),
            ],
          ),
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
            hintText: "What would you like to say?",
            focusedErrorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))));
  }
}
