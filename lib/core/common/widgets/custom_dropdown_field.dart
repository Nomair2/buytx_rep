import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final TextEditingController controller;
  final List<String>? list;
  final bool withDrop;

  void Function(String?)? onchange;

  CustomDropdownField({
    super.key,
    required this.controller,
    required this.withDrop,
    this.onchange,
    this.list,
  });

  _border() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: Colors.black),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.end,
      style: TextStyle(color: Colors.black),
      cursorColor: Theme.of(context).colorScheme.onSecondary,
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        focusedBorder: _border(),
        disabledBorder: _border(),
        border: _border(),
        enabledBorder: _border(),
        prefixIcon:
            withDrop
                ? DropdownButton(
                  alignment: AlignmentDirectional.center,
                  hint: null,
                  selectedItemBuilder: (context) => [SizedBox()],
                  padding: EdgeInsets.only(left: 20),
                  value: list![0],
                  menuWidth: 200,
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.black,
                  ),
                  underline: SizedBox.shrink(),
                  items:
                      list!
                          .map(
                            (type) => DropdownMenuItem(
                              alignment: AlignmentDirectional.center,
                              value: type,
                              child: Text(type, style: TextStyle(fontSize: 14)),
                            ),
                          )
                          .toList(),
                  onChanged: onchange,
                )
                : SizedBox.shrink(),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
