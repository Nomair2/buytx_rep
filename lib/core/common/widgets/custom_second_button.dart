import 'package:flutter/material.dart';

class CustomSecondButton extends StatelessWidget {
  final double width;
  final double height;
  void Function()? ontap;
  final Color color;
  final String text;
  CustomSecondButton({
    super.key,
    required this.width,
    required this.height,
    this.ontap,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.black),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
