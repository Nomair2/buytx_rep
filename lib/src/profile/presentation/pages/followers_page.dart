import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_search_field.dart';
import '../widgets/followers_tile.dart';

class FollowersPage extends StatefulWidget {
  FollowersPage({super.key, required this.index});
  int index;

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage>
    with TickerProviderStateMixin {
  final searchController = TextEditingController();
  late TabController tabCont;
  List<String> headers = ["المتابعين", "يتابع"];

  @override
  void initState() {
    super.initState();

    tabCont = TabController(length: 2, vsync: this, initialIndex: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 50),
            ZoomInDown(
              duration: const Duration(milliseconds: 900),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: CustomTextSearchField(
                    controller: searchController,
                  ),
                ),
              ),
            ),
            //==
            const SizedBox(height: 50),
            ZoomInDown(
              duration: const Duration(milliseconds: 1100),
              child: TabBar(
                controller: tabCont,
                labelColor: Theme.of(context).primaryColor,
                labelStyle: const TextStyle(fontSize: 18),
                unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
                indicatorColor: Theme.of(context).colorScheme.onSecondary,
                dividerColor: Colors.transparent,
                isScrollable: false,
                tabs: headers.map<Widget>((e) {
                  return Tab(
                    child: Text(e),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                children: [
                  //the followers
                  _followersBuildList(),
                  //who is following
                  _followingsBuildList(),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  ListView _followersBuildList() {
    return ListView.builder(
      itemCount: 7,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return FollowersTile(
          name: "سالم السالم",
          img: "assets/images/person.png",
          onPressed: () {},
          btnTile: "متابعة",
        );
      },
    );
  }

  //============================
  ListView _followingsBuildList() {
    return ListView.builder(
      itemCount: 7,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return FollowersTile(
          btnTile: "إلغاء المتابعة",
          name: "سالم السالم",
          img: "assets/images/person.png",
          onPressed: () {},
        );
      },
    );
  }
}
