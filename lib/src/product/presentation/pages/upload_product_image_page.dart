import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/widgets/custom_primary_button.dart';

class UploadProductImagePage extends StatefulWidget {
  const UploadProductImagePage({super.key});

  @override
  State<UploadProductImagePage> createState() => _UploadProductImagePageState();
}

class _UploadProductImagePageState extends State<UploadProductImagePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            color: theme.inversePrimary,
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 40),
              Text(
                "تحميل صورة /  فيديو",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 15),
              Container(
                width: width,
                height: height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: theme.inversePrimary),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 80,
                      right: 20,
                      child: InkWell(
                        onTap: () {},
                        child: RichText(
                          text: TextSpan(
                            text: "اضغط هنا ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                            children: [
                              TextSpan(
                                text: "لاختيار الصورة",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 130,
                      right: 20,
                      child: InkWell(
                        onTap: () {},
                        child: RichText(
                          text: TextSpan(
                            text: "اضغط هنا ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                            children: [
                              TextSpan(
                                text: "لاختيار الفيديو",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.1),
              CustomPrimaryButton(
                text: 'التالي',
                color: Theme.of(context).primaryColor,
                ontap: () {
                  context.pushNamed('productDetail2');
                },
                height: height * 0.05,
                width: width * 0.9,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
