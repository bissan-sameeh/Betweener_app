import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tt9_betweener_challenge/Helpers/snak_bar.dart';
import 'package:tt9_betweener_challenge/models/link.dart';
import 'package:tt9_betweener_challenge/views/widgets/gradiantText.dart';
import 'package:tt9_betweener_challenge/views/widgets/my_container.dart';

import '../controllers/add_follow.dart';
import '../controllers/link_controller.dart';
import '../controllers/user_controller.dart';
import '../models/followes.dart';
import '../models/founded_users.dart';
import '../models/user.dart';

class FriendProfile extends StatefulWidget {
  static const id = "/FriendProfile";
  const FriendProfile({Key? key}) : super(key: key);

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> with ShowSnackBar {
  late Future<List<Link>> links;
  late Future<User> user;
  late Follow followers;

  @override
  void initState() {
    links = getLinks(context);
    user = getLocalUser();

    super.initState();
  }

  getFollower() {}
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Follow;
    followers = args;

    // print('*******************************${args.linkSec?.length}');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GradientText(
                  'Friend Profile',
                  style: const TextStyle(fontSize: 40),
                  gradient: LinearGradient(colors: [
                    Colors.blue.shade400,
                    Colors.blue.shade900,
                  ]),
                ),
                SizedBox(
                  height: 12.h,
                ),

                ///personal info Card

                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        left: 20, right: 8, top: 12, bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xff2D2B4E)),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///picture
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 14.h,
                              ),
                              Center(
                                child: CircleAvatar(
                                  radius: 45.r,
                                  child: const Icon(Icons.person,
                                      size: 45, color: Color(0xff2D2B4E)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                followers.name ?? "bissan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                followers.email ?? "gmail@gmail.com",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              InkWell(
                                onTap: () {
                                  final body = {
                                    'followee_id': "${followers.id}"
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
                                child: const My_Container(
                                  text: 'Follow',
                                  isSmall: true,
                                ),
                              )
                            ],
                          ),
                        ])),

                SizedBox(
                  height: 24.h,
                ),

                ///Links

                Expanded(
                  child: ListView.builder(
                      // itemCount: followers.linkSec?.length,
                      itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: index % 2 == 0
                            ? const Color(0xffFEE2E7)
                            : const Color(0xffE7E5F1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            followers.SecLink![index].title ?? "snapshot",
                            style: const TextStyle(letterSpacing: 3),
                          ),
                          Text(
                            followers.SecLink![index].link ?? "hello@gmail.com",
                          ),
                        ],
                      ),
                    );
                  }),
                )
              ]),
        ),
      ),
    );
  }
}
