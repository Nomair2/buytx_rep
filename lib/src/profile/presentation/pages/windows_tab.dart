// ignore_for_file: unused_local_variable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_search_field.dart';
import '../widgets/window_card.dart';

class WindowsTab extends StatefulWidget {
  const WindowsTab({super.key});

  @override
  State<WindowsTab> createState() => _WindowsTabState();
}

class _WindowsTabState extends State<WindowsTab> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 20),
        ZoomInDown(
          duration: Duration(milliseconds: 1000),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              child: CustomTextSearchField(
                controller: searchController,
              ),
            ),
          ),
        ),
        //====
        // in this listView we will display the offers the user add from
        //create window page
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return ZoomInDown(
                duration: const Duration(milliseconds: 1100),
                child: WindowCard(
                  title: "عن المتجر",
                  img: "assets/images/store_exp.png",
                  content:
                      " تاجر محترف و موثوق متخصص في بيع القطع الإلكترونية ذات جودة عالية و أسعار تنافسية , خدمة عملاء مميزة , مع إلتزام بالمواعيد و الاحترام ذات جودة عالية و أسعار تنافسية , خدمة عملاء مميزة ",
                  editOnTap: () {},
                  deleteOnTap: () {},
                ),
              );
            }),
        const SizedBox(height: 400),
      ],
    );
  }
}

//====
