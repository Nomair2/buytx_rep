import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final void Function()? ontap;
  final String text;
  const CustomPrimaryButton(
      {super.key,
      required this.width,
      required this.ontap,
      required this.height,
      required this.color,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0, 6),
              spreadRadius: -1,
              color: Colors.black.withOpacity(0.2),
            )
          ],
          borderRadius: BorderRadius.circular(18),
          color: color,
        ),
        child: Center(
            child: text.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 18))),
      ),
    );
  }
}
