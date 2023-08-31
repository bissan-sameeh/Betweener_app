import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tt9_betweener_challenge/models/founded_users.dart';
import 'package:tt9_betweener_challenge/views/widgets/my_container.dart';
import 'package:tt9_betweener_challenge/views/widgets/my_text_field.dart';
import '../Helpers/snak_bar.dart';
import '../controllers/add_follow.dart';
import '../controllers/follower_controller.dart';
import '../controllers/search_controller.dart';
import '../models/followes.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);
  static const id = "/SearchView";
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with ShowSnackBar {
  TextEditingController searchController = TextEditingController();
  List<FoundedUsers>? foundedUsers = [];
  late Future<Followers> followers;
  Timer? _timer;
  search({required String query}) {
    final body = {
      "name": query,
    };
    searchUsers(body: body).then((value) {
      foundedUsers = value as List<FoundedUsers>?;
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    followers = viewFollower();
  }

  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(children: [
          MyTextField(
            controller: searchController,
            hint: 'search to find persons',
            suffix: Icons.search_outlined,
            onChanged: (val) {
              if (_timer?.isActive ?? false) _timer!.cancel();
              _timer = Timer(Duration(milliseconds: 500), () {
                search(query: val);
              });
            },
            prefix: null,
          ),
          SizedBox(
            height: 16.h,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, FriendProfile.id,
                          //     arguments: [followers]);
                        },
                        child: Text(
                          foundedUsers![index].name!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      FutureBuilder(
                        future: followers,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return InkWell(
                                onTap: () {
                                  final body = {
                                    'followee_id':
                                        "${snapshot.data!.followers![index].id}"
                                  };
                                  addFollow(body: body).then((checkAddFriend) {
                                    if (checkAddFriend == true && mounted) {
                                      showSnackBar(context,
                                          text: "Successes Process");
                                    }
                                  }).catchError((err) {
                                    //       print(err);
                                    showSnackBar(context,
                                        text: "You are Following these person",
                                        isError: true);
                                  });
                                },
                                child: const My_Container(text: "Add Follow"));
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 24.h,
                  );
                },
                itemCount: foundedUsers!.length),
          ),
        ]),
      ),
    ));
  }
}
