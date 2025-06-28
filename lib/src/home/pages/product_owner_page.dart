import 'package:animate_do/animate_do.dart';
import 'package:buytx/src/home/widgets/customCircularButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/common/widgets/product_card.dart';
import '../../../core/common/widgets/text_icon_button.dart';
import 'package:flutter/material.dart';
import '../../../core/configs/assets/app_image.dart';
import '../../profile/presentation/widgets/inapp_info_tile.dart';
import '../../profile/presentation/widgets/more_button.dart';

class ProductOwnerPage extends StatefulWidget {
  const ProductOwnerPage({super.key});
  static String name = "productProfilePage";

  @override
  State<ProductOwnerPage> createState() => _ProductOwnerPageState();
}

class _ProductOwnerPageState extends State<ProductOwnerPage> {
  bool isClicked = true;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
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

              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     FadeInLeft(
              //       duration: const Duration(milliseconds: 800),
              //       curve: Curves.linearToEaseOut,
              //       child: IconButton(
              //         onPressed: () {
              //           context.pop();
              //         },
              //         icon: Icon(
              //           Icons.arrow_back,
              //           color: Colors.black,
              //           size: 30,
              //         ),
              //       ),
              //     ),

              //     Container(
              //       // width: 30,
              //       padding: EdgeInsets.only(right: 10),
              //       child: FadeInRight(
              //         duration: const Duration(milliseconds: 800),
              //         curve: Curves.linearToEaseOut,
              //         child: MoreButton(
              //           colorIcon: Colors.white,
              //           colors: Colors.black,
              //           icons: Icons.more_vert,
              //           onPressed: () {},
              //           size: 22,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    _buildBg(height, width),
                    Transform.translate(
                      offset: Offset(0, -_scrollOffset * 0.5),
                      child: _userImage(height, width),
                    ),
                  ],
                ),
              ),
            ),

            //=====
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // SizedBox(height: height / 11),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
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
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const LoactionRateTile(),
                  const SizedBox(height: 40),
                  const UserSocialInfo(),
                  const SizedBox(height: 40),
                  Material(
                    child: ZoomInDown(
                      duration: const Duration(milliseconds: 1100),
                      child: FollowBtn(title: "متابعة", onTap: () {}),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Material(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FadeInLeftBig(
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.linearToEaseOut,
                          child: TextIconButton(
                            onTap: () {},
                            title: "تواصل",
                            icon: CupertinoIcons.phone,
                          ),
                        ),
                        FadeInRightBig(
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.linearToEaseOut,
                          child: TextIconButton(
                            onTap: () {},
                            title: "دردشة",
                            icon: Icons.chat_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: SlideInRight(
                      curve: Curves.linearToEaseOut,
                      child: Text(
                        "الوصف",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: SlideInRight(
                      curve: Curves.linearToEaseOut,
                      child: Text(
                        "أضمن أفضل المنتجات بأفضل الأسعار",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: SlideInRight(
                      curve: Curves.linearToEaseOut,
                      child: Text(
                        "السيرة الذاتية",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: SlideInRight(
                      curve: Curves.linearToEaseOut,
                      child: Text(
                        " تاجر محترف و موثوق متخصص في بيع القطع الإلكترونية ذات جودة عالية و أسعار تنافسية , خدمة عملاء مميزة , مع إلتزام بالمواعيد و الاحترام ذات جودة عالية و أسعار تنافسية , خدمة عملاء مميزة ",
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: SlideInRight(
                      curve: Curves.linearToEaseOut,
                      child: Text(
                        "الهاتف",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: SlideInRight(
                      curve: Curves.linearToEaseOut,
                      child: Text(
                        "095624525",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: SlideInRight(
                      curve: Curves.linearToEaseOut,
                      child: Text(
                        "العروض المشابهة",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            //=====
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: height,
                width: width,
                child: GridView.builder(
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      imagePath: 'assets/images/Rectangle.png',
                      location: '',
                      nameOwner: '',
                      changeColor: false,

                      nameProduct: '',
                      price: '',
                      timing: '',
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //=====
  Widget _userImage(double height, double width) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: Offset(0, -_scrollOffset * 1.5),
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
      ),
    );
  }

  //======
  Positioned _header(
    double height,
    BuildContext context,
    Function() backFunction,
    Function() moreFunction,
  ) {
    return Positioned(
      top: height / 13,
      right: 10,
      left: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeInLeft(
            duration: const Duration(milliseconds: 800),
            curve: Curves.linearToEaseOut,
            child: IconButton(
              onPressed: backFunction,
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onSecondary,
                size: 30,
              ),
            ),
          ),
          FadeInRight(
            duration: const Duration(milliseconds: 800),
            curve: Curves.linearToEaseOut,
            child: MoreButton(
              colorIcon: Theme.of(context).colorScheme.primaryContainer,
              colors: Theme.of(context).colorScheme.onSecondary,
              icons: Icons.more_vert,
              onPressed: moreFunction,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  //=====
  Positioned _buildBg(double height, double width) {
    return Positioned(
      child: Transform.translate(
        offset: Offset(0, -_scrollOffset * 0.3),
        child: SizedBox(
          height: height / 3,
          width: width,
          child: Image.asset(AppImage.profileBg, fit: BoxFit.fill),
        ),
      ),
    );
  }

  //=======
}

class FollowBtn extends StatelessWidget {
  const FollowBtn({super.key, required this.title, required this.onTap});
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [Color(0XFF9EACB7), Color(0XFF90DA5F)],
          ),
        ),
        child: Center(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
      ),
    );
  }
}

//=====
class UserSocialInfo extends StatelessWidget {
  const UserSocialInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ZoomInDown(
        // delay: Duration(milliseconds: 1000),
        duration: const Duration(milliseconds: 1000),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InappInfoTile(title: "المتابعين", value: "350", onTap: () {}),
            InappInfoTile(title: "يتابع", value: "150", onTap: () {}),
            InappInfoTile(title: "المبيعات", value: "50", onTap: () {}),
          ],
        ),
      ),
    );
  }
}

//=====
class LoactionRateTile extends StatelessWidget {
  const LoactionRateTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FadeInLeftBig(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.linearToEaseOut,
            child: Row(
              children: [
                Text(
                  "9.5 تقييم",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Icon(Icons.star, color: Theme.of(context).primaryColor),
              ],
            ),
          ),
          FadeInRightBig(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.linearToEaseOut,
            child: Row(
              children: [
                Text(
                  "سوريا - حمص",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Icon(Icons.location_on, color: Theme.of(context).primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
