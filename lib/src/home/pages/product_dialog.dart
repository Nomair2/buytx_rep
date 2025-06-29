import 'package:buytx/src/eveluatoin/presentation/pages/eveluation_page.dart';
import 'package:buytx/src/home/widgets/customCircularButton.dart';
import 'package:buytx/src/report/presentation/pages/report_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDialog extends StatefulWidget {
  const ProductDialog({super.key});

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topRight,
      child: Material(
        color: Colors.transparent,
        child: Container(
          // width: size.width * 0.5,
          // height: size.height * 0.3,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'الإعدادات',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // Divider with diamonds
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      Container(
                        height: 2,
                        width: 100,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      Container(
                        height: 10,
                        width: 10,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Actions
                  GestureDetector(
                    onTap: () {
                      context.pop();
                      context.pushNamed(EveluationPage.name);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'تقييم البائع',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(ReportPage.name);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'إبلاغ عن البائع',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.outlined_flag,
                          size: 20,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: CustomSmallButton(
                  colorIcon: Colors.black,
                  colors: Colors.white,
                  icons: Icons.close,
                  radius: 10,
                  onPressed: () {
                    context.pop();
                  },
                  size: 25,
                ),
              ),
              // Close button
              // Positioned(
              //   top: -8,
              //   left: -8,
              //   child: Material(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(16),
              //     child: InkWell(
              //       borderRadius: BorderRadius.circular(16),
              //       onTap: () => Navigator.of(context).pop(),
              //       child: const Padding(
              //         padding: EdgeInsets.all(6.0),
              //         child: Icon(
              //           Icons.close,
              //           size: 32,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
