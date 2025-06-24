import 'package:flutter/material.dart';
import 'package:buytx/core/configs/theme/app_colors.dart';

class CustomSmallButton extends StatelessWidget {
  CustomSmallButton({
    super.key,
    required this.icons,
    required this.onPressed,
    required this.colors,
    required this.colorIcon,
    required this.size,
    this.radius,
  });
  final IconData icons;
  final Color colors;
  final Color colorIcon;
  final VoidCallback onPressed;
  final double size;
  double? radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // height: height,
        // width: width,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: colors,
          border: Border.all(color: Colors.grey.withOpacity(0.7), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2.5,
              offset: Offset(0.0, 2),
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(radius ?? 70),
        ),
        child: Center(child: Icon(icons, color: colorIcon, size: size)),
      ),
    );
  }
}
