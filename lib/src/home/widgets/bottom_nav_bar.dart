import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_bloc.dart';
import 'package:buytx/src/home/data/product.dart' as prod;
import 'package:buytx/src/home/domain/products/bloc/products_bloc.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:buytx/core/services/route/router.dart';
import 'package:buytx/src/chat/presentaion/pages/all_chat_page.dart';
import 'package:buytx/src/home/pages/product_owner_page.dart';
import 'package:buytx/src/profile/presentation/pages/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  bool changeColor;
  BottomNavBar({super.key, required this.changeColor});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.09,
      constraints: BoxConstraints(minHeight: 82.875),
      child: Stack(
        children: [
          Container(
            height: size.height * 0.06,
            margin: EdgeInsets.only(top: 25),
            constraints: BoxConstraints(minHeight: 50.875),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = 3;
                    });
                    context.pushNamed(ProfilePage.name);
                  },
                  child: TweenAnimationBuilder<Color?>(
                    duration: Duration(milliseconds: 500), // مدة التغيير
                    curve: Curves.easeInOut, // منحنى الحركة
                    tween: ColorTween(
                      begin:
                          isSelected == 3
                              ? widget.changeColor
                                  ? Theme.of(context).secondaryHeaderColor
                                  : Theme.of(context).primaryColor
                              : Colors.white,
                      end:
                          isSelected == 3
                              ? widget.changeColor
                                  ? Theme.of(context).secondaryHeaderColor
                                  : Theme.of(context).primaryColor
                              : Colors.white,
                    ),
                    builder:
                        (context, value, child) =>
                            Icon(Icons.person, size: 28, color: value),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = 2;
                    });
                    context.pushNamed(
                      AllChatPage.name,
                      extra: context.read<messagesBloc>(),
                    );
                  },
                  child: TweenAnimationBuilder<Color?>(
                    duration: Duration(milliseconds: 500), // مدة التغيير
                    curve: Curves.easeInOut, // منحنى الحركة
                    tween: ColorTween(
                      begin:
                          isSelected == 2
                              ? widget.changeColor
                                  ? Theme.of(context).secondaryHeaderColor
                                  : Theme.of(context).primaryColor
                              : Colors.white,
                      end:
                          isSelected == 2
                              ? widget.changeColor
                                  ? Theme.of(context).secondaryHeaderColor
                                  : Theme.of(context).primaryColor
                              : Colors.white,
                    ),
                    builder:
                        (context, value, child) =>
                            Icon(Icons.chat, size: 28, color: value),
                  ),
                ),
                SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = 1;
                    });
                  },
                  child: TweenAnimationBuilder<Color?>(
                    duration: Duration(milliseconds: 500), // مدة التغيير
                    curve: Curves.easeInOut, // منحنى الحركة
                    tween: ColorTween(
                      begin:
                          isSelected == 1
                              ? widget.changeColor
                                  ? Theme.of(context).secondaryHeaderColor
                                  : Theme.of(context).primaryColor
                              : Colors.white,
                      end:
                          isSelected == 1
                              ? widget.changeColor
                                  ? Theme.of(context).secondaryHeaderColor
                                  : Theme.of(context).primaryColor
                              : Colors.white,
                    ),
                    builder:
                        (context, value, child) => Icon(
                          Icons.favorite_outlined,
                          size: 28,
                          color: value,
                        ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = 0;
                    });
                  },
                  child: TweenAnimationBuilder<Color?>(
                    duration: Duration(milliseconds: 500), // مدة التغيير
                    curve: Curves.easeInOut, // منحنى الحركة
                    tween: ColorTween(
                      begin:
                          isSelected == 0
                              ? widget.changeColor
                                  ? Theme.of(context).secondaryHeaderColor
                                  : Theme.of(context).primaryColor
                              : Colors.white,
                      end:
                          isSelected == 0
                              ? widget.changeColor
                                  ? Theme.of(context).secondaryHeaderColor
                                  : Theme.of(context).primaryColor
                              : Colors.white,
                    ),
                    builder:
                        (context, value, child) => Icon(
                          Icons.home,
                          // FluentIcons.home_32_regular,
                          size: 28,
                          color: value,
                        ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<ProductsBloc>().add(
                AddProduct(
                  prod.Product(
                    title: "IPhone",
                    price: prod.Price(amount: 10, currency: "SYP"),
                    description: "A Phone, which is very overpriced.",
                    category: "683483dde483119f4991d6b3",
                    phone: "+963994935356",
                    location: prod.ProductLocation(
                      location: "682130e68c44576b824557df",
                      details: "Near Safita",
                    ),
                    condition: "شراء",
                    quantity: 2,
                    images: [
                      prod.ImageInfo(
                        high: "products/1748561481788_1000178477.jpg",
                        med: "products/1748561482679_1000178477_low.jpg",
                        low: "products/1748561482679_1000178477_low.jpg",
                      ),
                    ],
                    videos: ["products/1746109631512_1000003227.mp4"],
                    tags: ["الكترونيات", "جديد", "iPhone", "smartphone"],
                  ),
                ),
              );
            },
            child: Center(
              // left: size.width * 0.4,
              child: AnimatedContainer(
                duration: Duration(seconds: 1), // مدة التغيير
                curve: Curves.easeInOut, // منحنى الحركة
                constraints: BoxConstraints(minHeight: 50, minWidth: 50.875),
                // height: size.height * 0.07,
                // width: size.width * 0.14,
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color:
                      widget.changeColor
                          ? Theme.of(context).secondaryHeaderColor
                          : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Icon(Icons.add, size: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
