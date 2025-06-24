import 'package:flutter/material.dart';

class WindowCard extends StatelessWidget {
  const WindowCard({
    super.key,
    required this.title,
    required this.content,
    required this.editOnTap,
    required this.deleteOnTap,
    required this.img,
  });
  final String title;
  final String content;
  final String img;
  final Function() editOnTap;
  final Function() deleteOnTap;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: width / 1.1,
            height: height / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // color: Colors.black,
            ),
            //later we will change it to image.network
            //when we will display image from api
            child: Image.asset(img, fit: BoxFit.fill),
          ),
          const SizedBox(height: 15),
          Text(
            content,
            style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                fontSize: 16,
                decoration: TextDecoration.none),
            textAlign: TextAlign.end,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Material(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: deleteOnTap,
                    child: const Row(
                      children: [
                        Icon(Icons.delete_outline_outlined, color: Colors.red),
                        Text(
                          "حذف",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: editOnTap,
                    child: const Row(
                      children: [
                        Icon(Icons.edit, color: Colors.green),
                        Text(
                          "تعديل",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
