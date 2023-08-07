import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/models/link.dart';
import 'package:tt9_betweener_challenge/views/add_link_view.dart';
import 'package:tt9_betweener_challenge/views/follower_view.dart';

import '../constants.dart';
import '../controllers/delete_link_controller.dart';
import 'edit_view.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<List<Link>> links;

  @override
  void initState() {
    links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Profile",
            style: TextStyle(fontSize: 24.sp),
          ),
          SizedBox(
            height: 12.h,
          ),

          ///personal info Card
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 20, right: 12, top: 12, bottom: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff2D2B4E)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 45.r,
                  child: const Icon(Icons.person,
                      size: 45, color: Color(0xff2D2B4E)),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Johan Doe",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "example",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "example",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        buildContainer(
                            text: "follower 203",
                            function: () {
                              Navigator.pushNamed(context, FollowersView.id);
                            }),
                        SizedBox(
                          width: 8.w,
                        ),
                        buildContainer(text: 'following 100')
                      ],
                    ),
                  ],
                ),
                const Icon(
                  Icons.edit,
                  color: Colors.white,
                )
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),

          ///Links

          FutureBuilder(
            future: links,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return SizedBox(
                height: 300.h,
                child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SizedBox(
                              width: 8.w,
                            ),
                            buildSlidableAction(
                                icon: Icons.delete,
                                color: kSecondaryColor,
                                function: (check) {
                                  final body = {
                                    'title': snapshot.data![index].title,
                                    'link': snapshot.data![index].link
                                  };
                                  deleteLink(
                                          body: body,
                                          userId: snapshot.data![index].id)
                                      .then((value) {
                                    if (value == true) {
                                      setState(() {
                                        links = getLinks(context);
                                      });
                                    }
                                  });
                                }),
                            SizedBox(
                              width: 8.w,
                            ),
                            buildSlidableAction(
                                icon: Icons.edit,
                                color: kDangerColor,
                                function: (check) {
                                  Navigator.pushNamed(context, EditeView.id,
                                      arguments: [
                                        snapshot.data![index].title,
                                        snapshot.data![index].link,
                                        snapshot.data![index].id,
                                      ]).then((checkData) {
                                    final result = checkData;
                                    if (result == true) {
                                      setState(() {
                                        links = getLinks(context);
                                      });
                                    }
                                  });
                                }),
                          ],
                        ),
                        child: Container(
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
                                snapshot.data![index].title!,
                                style: TextStyle(letterSpacing: 3),
                              ),
                              Text(snapshot.data![index].link!),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26.r,
                backgroundColor: const Color(0xff2D2B4E),
                child: InkWell(
                  onTap: () async {
                    await Navigator.pushNamed(context, AddLinkView.id)
                        .then((value) {
                      setState(() {
                        links = getLinks(context);
                      });
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100.h,
          )
        ],
      ),
    );
  }

  SlidableAction buildSlidableAction(
      {required IconData icon,
      required Color color,
      Function(dynamic)? function}) {
    return SlidableAction(
      borderRadius: BorderRadius.circular(15),
      onPressed: function,
      icon: icon,
      backgroundColor: color,
    );
  }

  InkWell buildContainer({required String text, Function()? function}) {
    return InkWell(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: const Color(0xffFFD465),
            borderRadius: BorderRadius.circular(8.r)),
        child: Text(text),
      ),
    );
  }
}
