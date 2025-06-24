import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buytx/core/configs/theme/app_colors.dart';

class CustomChooseButton extends StatelessWidget {
  final Widget child;
  final Color color;
  // final int flex;
  const CustomChooseButton({
    super.key,
    required this.child,
    required this.color,
    // required this.flex
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 36,
      constraints: BoxConstraints(minWidth: 155),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(child: child),
    );
  }
}

class CustomChooseHomeButton extends StatelessWidget {
  final Widget child;
  final void Function()? ontap;
  final bool isChoosed;
  final bool changeColor;
  // final int flex;
  const CustomChooseHomeButton({
    super.key,
    required this.child,
    required this.ontap,
    required this.isChoosed,
    required this.changeColor,
    // required this.flex
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ontap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400), // مدة التغيير
        curve: Curves.easeInOut, // منحنى الحركة
        // color: _color,
        height: 36,
        constraints: BoxConstraints(minWidth: 155),
        decoration: BoxDecoration(
          color:
              isChoosed
                  ? changeColor
                      ? Theme.of(context).secondaryHeaderColor
                      : Theme.of(context).primaryColor
                  : AppColors.backgroundCategories,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(child: child),
      ),
    );
  }
}
