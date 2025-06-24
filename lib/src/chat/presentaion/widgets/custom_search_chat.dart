import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchChat extends StatelessWidget {
  const CustomSearchChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        // width: size.width,
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                offset: const Offset(0, 6),
                spreadRadius: -1,
                color: Colors.black.withOpacity(0.2),
              ),
            ],
            border: Border.all(color: Colors.black),
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(18)),
        child: Center(
          child: TextFormField(
            // validator: validate,
            controller: TextEditingController(),
            keyboardType: TextInputType.text,
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              hintText: "أبحث عن الدردشات",
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 18),
              border: InputBorder.none,
              suffixIcon: Icon(
                // Ionicons.ios_search,
                CupertinoIcons.search,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
