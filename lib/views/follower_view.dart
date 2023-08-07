import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tt9_betweener_challenge/models/followes.dart';

import '../controllers/follower_controller.dart';

class FollowersView extends StatefulWidget {
  static const id = "/Followers";
  const FollowersView({Key? key}) : super(key: key);

  @override
  State<FollowersView> createState() => _FollowersState();
}

class _FollowersState extends State<FollowersView> {
  late Future<List<Follower>> followers;
  // getFollowers() {
  //   viewFollower().then((value) => followes=value);
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    followers = viewFollower();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Followers"),
            FutureBuilder(
              future: followers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.blueAccent,
                  );
                }
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Row(
                          children: [
                            Text(snapshot.data![index].name! ?? "jhj"),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 16.h,
                      );
                    },
                    itemCount: snapshot.data!.length,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
