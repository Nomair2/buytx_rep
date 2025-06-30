import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:buytx/core/configs/theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String nameProduct;
  final String timing;
  final String? price;
  final String nameOwner;
  final String location;
  final bool changeColor;
  ProductCard({
    required this.imagePath,
    required this.nameProduct,
    required this.timing,
    this.price,
    required this.nameOwner,
    required this.changeColor,
    required this.location,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      width: size.width * 0.44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      clipBehavior:
                          Clip.antiAlias, // Ensures content is clipped to borderRadius
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(8),
                      child: CachedNetworkImage(
                        imageUrl: imagePath,
                        errorWidget: (context, url, error) {
                          return Text("IMAGE");
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: const Center(
                          child: Icon(Icons.favorite_border, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400), // مدة التغيير
                    curve: Curves.easeInOut,
                    width: double.infinity,
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    decoration: BoxDecoration(
                      color:
                          (changeColor ?? false)
                              ? Theme.of(context).secondaryHeaderColor
                              : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Text(nameProduct)),
                  ),

                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (price?.isNotEmpty ?? false)
                          ? Container(
                            width:
                                isLandscape
                                    ? size.width * 0.1
                                    : size.width * 0.15,
                            child: Text(
                              "${price ?? ''}\$  ",
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,

                                fontWeight: FontWeight.bold,
                                color:
                                    (changeColor ?? false)
                                        ? Theme.of(context).secondaryHeaderColor
                                        : Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                          : SizedBox(),

                      Row(
                        children: [
                          SizedBox(
                            width:
                                isLandscape
                                    ? size.width * 0.1
                                    : size.width * 0.15,
                            child: Text(
                              '${timing} ' + 'دقائق',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.access_time,
                            color:
                                (changeColor ?? false)
                                    ? Theme.of(context).secondaryHeaderColor
                                    : Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (!isLandscape) const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width:
                            isLandscape ? size.width * 0.1 : size.width * 0.14,
                        child: Text(
                          location,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w600,
                            color:
                                (changeColor ?? false)
                                    ? Theme.of(context).secondaryHeaderColor
                                    : Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width:
                                isLandscape
                                    ? size.width * 0.1
                                    : size.width * 0.18,
                            child: Text(
                              nameOwner,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          SizedBox(width: 6),
                          Icon(
                            Icons.person,
                            color:
                                (changeColor ?? false)
                                    ? Theme.of(context).secondaryHeaderColor
                                    : Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ],
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
