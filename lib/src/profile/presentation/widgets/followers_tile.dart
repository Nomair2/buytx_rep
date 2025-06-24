import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../pages/dealer_info_tab.dart';

class FollowersTile extends StatelessWidget {
  const FollowersTile({
    super.key,
    required this.name,
    required this.img,
    required this.onPressed,
    required this.btnTile,
  });
  final String name;
  final String btnTile;
  final String img;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SlideInLeft(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              child: InfoStatusBtn(text: btnTile, onPressed: onPressed)),
          SlideInRight(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            child: Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  //later we will change it with Network image from api
                  backgroundImage: AssetImage(img),
                  radius: 35,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
