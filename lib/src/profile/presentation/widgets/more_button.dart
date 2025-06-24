// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:buytx/core/configs/theme/app_colors.dart';

class MoreButton extends StatelessWidget {
  MoreButton({
    super.key,
    required this.icons,
    required this.onPressed,
    required this.colors,
    required this.colorIcon,
    required this.size,
  });
  final IconData icons;
  final Color colors;
  final Color colorIcon;
  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // height: height,
        // width: width,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: colors,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2.5,
              offset: const Offset(0.0, 2),
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Icon(icons, color: colorIcon, size: size)),
      ),
    );
  }
}
