import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/views/search_view.dart';

import '../constants.dart';
import '../models/link.dart';
import '../models/user.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User>
      user; //late because we not decompose the data yet ! and the same type of data returned of getLocalUser func.
  late Future<List<Link>> links;

  @override
  void initState() {
    super.initState();
    user =
        getLocalUser(); //her we call the function and assigned it to the same type of data Future <user>
    links = getLinks(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, SearchView.id);
                  },
                  child: const Icon(
                    Icons.search,
                    size: 30,
                  )),
              SizedBox(
                width: 12.w,
              ),
              InkWell(
                  onTap: () {},
                  child: const Icon(Icons.qr_code_sharp, size: 30)),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          FutureBuilder(
            future: user,
            //her instead use fun getLocalUser and each time we rebuild it will turned on again we keep the data and such as use then her
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  'Welcome ${snapshot.data?.user?.name}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                );
              }
              return Text('loading');
            },
          ),
          Container(
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
                // // color: Colors.blue,
                // borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                // border: Border(right: BorderSide(color: Colors.black26)),
                ),
            child: Image.asset(
              "assets/imgs/qr_code.png",
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.0.w),
            child: Divider(
              color: Colors.black,
              thickness: 2,
              height: 12.h,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          FutureBuilder(
            future: links,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 100.h,
                  child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(12),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final title = snapshot.data?[index].title;
                        final link = snapshot.data?[index].link;
                        return Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: kLinksColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$title',
                                style: const TextStyle(
                                    color: Colors.white, letterSpacing: 3),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                '$link',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 12.w,
                        );
                      },
                      itemCount: snapshot.data!.length),
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Text('loading');
            },
          ),
        ],
      ),
    );
  }
}
