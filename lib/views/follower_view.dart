import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tt9_betweener_challenge/Helpers/snak_bar.dart';
import 'package:tt9_betweener_challenge/models/followes.dart';
import 'package:tt9_betweener_challenge/views/widgets/gradiantText.dart';
import 'package:tt9_betweener_challenge/views/widgets/my_container.dart';

import '../controllers/add_follow.dart';
import '../controllers/follower_controller.dart';
import 'friend_profile.dart';

class FollowersView extends StatefulWidget {
  static const id = "/Followers";

  const FollowersView({Key? key}) : super(key: key);

  @override
  State<FollowersView> createState() => _FollowersState();
}

class _FollowersState extends State<FollowersView> with ShowSnackBar {
  late Future<Followers> followers;
  bool? following = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    followers = viewFollower();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as bool;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GradientText(
                args == false ? 'Followers' : 'Followings',
                style: const TextStyle(fontSize: 40),
                gradient: LinearGradient(colors: [
                  Colors.blue.shade400,
                  Colors.blue.shade900,
                ]),
              ),
              SizedBox(
                height: 24.h,
              ),
              args == false
                  ? FutureBuilder(
                      future: followers,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, FriendProfile.id,
                                            arguments: snapshot
                                                .data!.followers![index]);
                                      },
                                      child: GradientText(
                                        snapshot.data!.followers![index].name ??
                                            "jhj",
                                        style: TextStyle(fontSize: 16.sp),
                                        gradient: LinearGradient(colors: [
                                          Colors.blue.shade300,
                                          Colors.blue.shade500,
                                        ]),
                                      ),
                                    ),
                                    const My_Container(
                                      text: 'Remove',
                                      isSmall: true,
                                    ),
                                  ],
                                );
                                //   padding: const EdgeInsets.all(12),
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 16.h,
                                );
                              },
                              itemCount: snapshot.data!.followers!.length,
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          );
                        }
                      },
                    )
                  : FutureBuilder(
                      future: followers,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, FriendProfile.id,
                                            arguments: snapshot
                                                .data!.following![index]);
                                      },
                                      child: GradientText(
                                        snapshot.data!.following![index].name ??
                                            "jhj",
                                        style: TextStyle(fontSize: 16.sp),
                                        gradient: LinearGradient(colors: [
                                          Colors.blue.shade300,
                                          Colors.blue.shade500,
                                        ]),
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
                                                      "${snapshot.data!.following![index].id}"
                                                };
                                                addFollow(body: body)
                                                    .then((checkAddFriend) {
                                                  if (checkAddFriend == true &&
                                                      mounted) {
                                                    showSnackBar(context,
                                                        text:
                                                            "Successes Process");
                                                  }
                                                }).catchError((err) {
                                                  //       print(err);
                                                  showSnackBar(context,
                                                      text:
                                                          "You are Following these person",
                                                      isError: true);
                                                });
                                              },
                                              child: const My_Container(
                                                text: "Add Follow",
                                                isSmall: true,
                                              ));
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                  ],
                                );
                                //   padding: const EdgeInsets.all(12),
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 16.h,
                                );
                              },
                              itemCount: snapshot.data!.following!.length,
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          );
                        }
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
