import 'package:buytx/core/common/widgets/custom_dropdown_field.dart';
import 'package:buytx/src/product/presentation/pages/product_detail_page2.dart';
import 'package:buytx/src/product/presentation/pages/upload_product_image_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';

class ProductDetailPage1 extends StatefulWidget {
  static String name = 'productDetailPage1';
  const ProductDetailPage1({super.key});

  @override
  State<ProductDetailPage1> createState() => _ProductDetailPage1State();
}

class _ProductDetailPage1State extends State<ProductDetailPage1> {
  List<String> cities = [
    'دمشق',
    'ريف دمشق',
    'درعا',
    'السويداء',
    'حمص',
    'حماة',
    'طرطوس',
    'اللاذقية',
    'إدلب',
    'حلب',
    'الرقة',
    'دير الزور',
    'الحسكة',
    'القنيطرة',
  ];
  List<String> subCityes = [
    'الإنشاءات',
    'اعزاز ',
    'جرابلس ',
    'جبل سمعان',
    'عين العرب',
    'منبج ',
    'المحطة',
    'الغوطة',
  ];
  // Store both images and videos with their types
  List<Map<String, dynamic>?> _mediaItems = [null, null, null];
  final ImagePicker _picker = ImagePicker();
  TextEditingController city = TextEditingController();
  TextEditingController subCity = TextEditingController();
  TextEditingController details = TextEditingController();

  _border() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: Colors.black),
  );

  // Show media picker dialog
  void _showMediaPicker(int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'اختر نوع الملف',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMediaOption(
                          icon: Icons.photo_library,
                          label: 'صورة',
                          onTap: () => _pickImage(index),
                        ),
                        _buildMediaOption(
                          icon: Icons.videocam,
                          label: 'فيديو',
                          onTap: () => _pickVideo(index),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMediaOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Pick image from gallery
  Future<void> _pickImage(int index) async {
    Navigator.pop(context); // Close bottom sheet
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _mediaItems[index] = {
            'type': 'image',
            'file': File(image.path),
            'provider': FileImage(File(image.path)),
          };
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطأ في اختيار الصورة: $e')));
    }
  }

  // Pick video from gallery
  Future<void> _pickVideo(int index) async {
    Navigator.pop(context); // Close bottom sheet
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: Duration(minutes: 5),
      );

      if (video != null) {
        setState(() {
          _mediaItems[index] = {
            'type': 'video',
            'file': File(video.path),
            'path': video.path,
          };
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطأ في اختيار الفيديو: $e')));
    }
  }

  // Build media display widget for each media slot
  Widget _buildMediaDisplay(int index) {
    final mediaItem = _mediaItems[index];

    if (mediaItem == null) {
      // Show placeholder when no media is selected
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 30,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 4),
          Text(
            'إضافة',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
        ],
      );
    }

    if (mediaItem['type'] == 'image') {
      // Display image
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          mediaItem['file'],
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else if (mediaItem['type'] == 'video') {
      // Display video thumbnail with play icon
      return Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.videocam, size: 30, color: Colors.grey.shade600),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(Icons.play_arrow, size: 16, color: Colors.white),
            ),
          ),
        ],
      );
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    city.text = cities[0];
    subCity.text = subCityes[0];
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        leading: SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            color: theme.onSecondary,
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () => _showMediaPicker(i),
                            child: Container(
                              width:
                                  orientation == Orientation.landscape
                                      ? width * 0.2
                                      : width * 0.1,
                              height:
                                  orientation == Orientation.landscape
                                      ? height * 0.2
                                      : height * 0.1,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: _buildMediaDisplay(i),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  ":اختر المدينة *",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: theme.inverseSurface),
                ),
                const SizedBox(height: 15),
                CustomDropdownField(
                  controller: city,
                  list: cities,
                  withDrop: true,
                ),
                const SizedBox(height: 30),
                Text(
                  ":اختر الحي * ",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: theme.inverseSurface),
                ),
                const SizedBox(height: 15),

                CustomDropdownField(
                  controller: subCity,
                  list: subCityes,
                  withDrop: true,
                ),

                const SizedBox(height: 30),
                Text(
                  ":تفاصيل أكثر عن العنوان (إختياري) * ",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: theme.inverseSurface),
                ),
                const SizedBox(height: 15),

                CustomDropdownField(controller: details, withDrop: false),
                SizedBox(height: height * 0.1),
                CustomPrimaryButton(
                  text: 'التالي',
                  color: Theme.of(context).primaryColor,
                  ontap: () {
                    context.pushNamed(ProductDetailPage2.name);
                  },
                  height: height * 0.05,
                  width: width * 0.9,
                ),
                SizedBox(height: height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
