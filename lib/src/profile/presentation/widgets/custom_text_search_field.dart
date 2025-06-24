import 'package:flutter/material.dart';


class CustomTextSearchField extends StatelessWidget {
  const CustomTextSearchField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "بحث",
        hintStyle: Theme.of(context).textTheme.bodySmall,
        hintTextDirection: TextDirection.rtl,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        filled: true,
        suffixIcon: Icon(Icons.search,
            color: Theme.of(context).colorScheme.onSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primaryContainer,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primaryContainer,
            )),
      ),
    );
  }
}
