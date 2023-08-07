import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tt9_betweener_challenge/models/founded_users.dart';
import 'package:tt9_betweener_challenge/views/widgets/my_text_field.dart';

import '../controllers/search_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);
  static const id = "/SearchView";
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController();

  List<FoundedUsers>? foundedUsers = [];
  search() {
    final body = {
      "name": searchController.text,
    };
    searchUsers(body: body).then((value) => foundedUsers = value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            hint: 'search to find pesrons',
            suffix: Icons.search_outlined,
            onPressed: search,
            prefix: null,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(foundedUsers![index].name! ?? "anythings"),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 16.h,
                  );
                },
                itemCount: foundedUsers!.length),
          ),
        ]),
      ),
    ));
  }
}
