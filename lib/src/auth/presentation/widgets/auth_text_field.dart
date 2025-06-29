import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  bool? scure;
  final String text;
  final TextEditingController controller;
  Widget? preIcon;
  Widget? sufIcon;
  Color? colorbg;
  String? Function(String?)? validtor;
  TextStyle? hintStyle;
  AuthTextField({
    super.key,
    // required this.size,
    required this.text,
    required this.controller,
    this.scure,
    this.colorbg,
    this.hintStyle,
    this.validtor,
    this.preIcon,
    this.sufIcon,
  });

  OutlineInputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Colors.green, width: 2),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: scure ?? false,
      controller: controller,
      textAlign: TextAlign.end,
      cursorColor: const Color(0xff919296),
      validator: validtor,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Color(0xff919296),
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: text,
        hintStyle:
            hintStyle ??
            const TextStyle(
              color: Color(0xff919296),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: preIcon,
        suffixIcon: sufIcon,
        hintMaxLines: 1,
        contentPadding: const EdgeInsets.only(left: 14, top: 0, bottom: 0),
        filled: true,
        fillColor: colorbg ?? Theme.of(context).colorScheme.onBackground,
        border: _inputBorder,
        // enabledBorder: _inputBorder,
        focusedBorder: _inputBorder,
      ),
    );
  }
}

      // width: size.width,
      // width: double.infinity,
      // height: 36,
      // decoration: BoxDecoration(
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 2,
      //         offset: Offset(0, 6),
      //         spreadRadius: -1,
      //         color: Colors.black.withOpacity(0.2),
      //       ),
      //     ],
      //     color: Theme.of(context).colorScheme.onBackground,
      //     border: Border.all(color: Color(0xff72B745), width: 1),
      //     borderRadius: BorderRadius.circular(18)),