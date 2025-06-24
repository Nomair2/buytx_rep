import 'package:animate_do/animate_do.dart';
import 'package:buytx/src/home/widgets/customCircularButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:buytx/core/services/route/router.dart';
import 'package:buytx/src/profile/presentation/pages/windows_tab.dart';

import '../../../../core/configs/assets/app_image.dart';
import '../widgets/profile_tab.dart';
import '../widgets/more_button.dart';
import 'dealer_info_tab.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String name = 'profilePage';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isClicked = true;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            expandedHeight: height / 2.6,
            pinned: true,
            leadingWidth: double.maxFinite,
            floating: false,
            leading: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeInLeft(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.linearToEaseOut,
                    child: CustomSmallButton(
                      colorIcon: Colors.black,
                      colors: Colors.white,
                      icons: CupertinoIcons.back,
                      radius: 10,
                      onPressed: () {
                        context.pop();
                      },
                      size: 25,
                    ),
                  ),
                  FadeInLeft(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.linearToEaseOut,
                    child: CustomSmallButton(
                      colorIcon: Colors.black,
                      colors: Colors.white,
                      icons: Icons.more_vert,
                      radius: 10,
                      onPressed: () {},
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
            // title:
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [Icon(Icons.dns_sharp), Icon(Icons.dns_sharp)],
            // ),
            // _header(height, context, () {
            //   context.pop();
            // }, () {}),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  _buildBg(height, width),

                  //-----
                  _userImage(height, width),
                ],
              ),
            ),
          ),
          //=====
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: height / 11),
                //this is the status of this account
                ZoomInDown(
                  duration: const Duration(milliseconds: 750),
                  child: Text(
                    "متصل",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                //this is the name of the user
                ZoomInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    "أغيد علوان",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
                //this is the user tag
                ZoomInDown(
                  delay: const Duration(milliseconds: 850),
                  child: Text(
                    "@Aghiad _2Ex",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 30),
                Material(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FadeInLeftBig(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.linearToEaseOut,
                        child: ProfileTabButton(
                          title: "النوافذ",
                          isActive: !isClicked,
                          onpressed: () {
                            setState(() {
                              isClicked = !isClicked;
                            });
                          },
                        ),
                      ),
                      FadeInRightBig(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.linearToEaseOut,
                        child: ProfileTabButton(
                          title: "معلوماتي",
                          isActive: isClicked,
                          onpressed: () {
                            setState(() {
                              isClicked = !isClicked;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                //in this condition we display the user info
                if (isClicked) const DealerInfoTab(),

                if (!isClicked) const WindowsTab(),
              ],
            ),
          ),
          //=====
        ],
      ),
    );
  }

  Widget _userImage(double height, double width) {
    return Container(
      // top: height / 4.9,
      // left: width / 2.9, c
      alignment: Alignment.bottomCenter,
      child: ZoomInDown(
        duration: const Duration(milliseconds: 700),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const CircleAvatar(
            backgroundImage:
            //later we bring the image from the api
            AssetImage("assets/images/person.png"),
            radius: 70,
          ),
        ),
      ),
    );
  }

  //======
  Widget _header(
    double height,
    BuildContext context,
    Function() backFunction,
    Function() moreFunction,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          alignment: Alignment.topRight,
          child: FadeInRight(
            duration: const Duration(milliseconds: 800),
            curve: Curves.linearToEaseOut,
            child: MoreButton(
              colorIcon: Colors.white,
              colors: Colors.black,
              icons: Icons.more_vert,
              onPressed: moreFunction,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  //=========
  Positioned _buildBg(double height, double width) {
    return Positioned(
      child: SizedBox(
        height: height / 3,
        width: width,
        child: Image.asset(AppImage.profileBg, fit: BoxFit.fill),
      ),
    );
  }

  //=======
}
