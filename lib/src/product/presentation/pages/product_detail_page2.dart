import 'package:buytx/core/common/widgets/custom_dropdown_field.dart';
import 'package:buytx/src/product/presentation/pages/policy_page.dart';
import 'package:buytx/src/profile/presentation/pages/create_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../auth/presentation/widgets/auth_text_field.dart';

class ProductDetailPage2 extends StatefulWidget {
  static String name = 'productDetailPage2';
  const ProductDetailPage2({super.key});

  @override
  State<ProductDetailPage2> createState() => _ProductDetailPage2State();
}

class _ProductDetailPage2State extends State<ProductDetailPage2> {
  TextEditingController nameProduct = TextEditingController();
  TextEditingController type1 = TextEditingController();
  TextEditingController type2 = TextEditingController();
  TextEditingController type3 = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController priceSYP = TextEditingController();
  TextEditingController priceDollar = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController tagController = TextEditingController();

  // List to store tags
  List<String> tags = [];

  // List of colors for tags
  List<Color> tagColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.indigo,
    Colors.pink,
  ];

  List<String> types1 = [
    'هواتف',
    'لابتوبات',
    'عقارات',
    'ملابس',
    'سيارات',
    'كتب',
    'ألعاب إلكترونية',
    'أثاث',
  ];

  // Method to add a new tag
  void _addTag() {
    if (tagController.text.trim().isNotEmpty) {
      setState(() {
        tags.add(tagController.text.trim());
        tagController.clear();
      });
    }
  }

  OutlineInputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Colors.black, width: 1),
  );

  // Method to remove a tag
  void _removeTag(int index) {
    setState(() {
      tags.removeAt(index);
    });
  }

  // Method to build tag widgets
  Widget _buildTagsDisplay() {
    if (tags.isEmpty) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            tags.asMap().entries.map((entry) {
              int index = entry.key;
              String tag = entry.value;
              Color tagColor = tagColors[index % tagColors.length];

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: tagColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: tagColor, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tag,
                      style: TextStyle(
                        color: tagColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => _removeTag(index),
                      child: Icon(Icons.close, size: 16, color: tagColor),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
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
                const SizedBox(height: 30),

                Text(
                  "اسم المنتج *",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: theme.inverseSurface),
                ),
                const SizedBox(height: 15),
                CustomDropdownField(controller: nameProduct, withDrop: false),
                const SizedBox(height: 40),
                Text(
                  ": القسم *",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: theme.inverseSurface),
                ),
                const SizedBox(height: 15),
                //THIS DROPDOWN MENU FOR PRODUCT TYPES (PHONES , CLOTHS ETC)
                CustomDropdownField(
                  controller: type1,
                  list: types1,
                  withDrop: true,
                ),
                const SizedBox(height: 40),
                //THIS DROPDOWN WILL HAS BRANDS DEPENDING ON PRODUCT TYPE
                CustomDropdownField(
                  controller: type2,
                  list: types1,
                  withDrop: true,
                ),
                const SizedBox(height: 40),
                CustomDropdownField(
                  controller: type2,
                  list: types1,
                  withDrop: true,
                ),
                const SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: SwitchListTile(
                    value: true,
                    onChanged: (val) {},
                    title: Text(
                      'إظهار رقم الهاتف',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: theme.inverseSurface,
                      ),
                    ),
                    activeColor: Theme.of(context).primaryColor,
                    inactiveThumbColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                CustomDropdownField(controller: phone, withDrop: false),
                const SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: SwitchListTile(
                    value: true,
                    onChanged: (val) {},
                    title: Text(
                      'تحديد السعر',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: theme.inverseSurface,
                      ),
                    ),
                    activeColor: Theme.of(context).primaryColor,
                    inactiveThumbColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                CustomDropdownField(controller: priceSYP, withDrop: false),
                const SizedBox(height: 20),
                CustomDropdownField(controller: priceDollar, withDrop: false),
                const SizedBox(height: 40),
                Text(
                  "حالة المنتج",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: theme.inverseSurface),
                ),
                const SizedBox(height: 15),
                CustomDropdownField(
                  controller: status,
                  list: types1,
                  withDrop: true,
                ),
                const SizedBox(height: 40),
                Text(
                  "tag إضافة",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: theme.inverseSurface),
                ),
                const SizedBox(height: 15),
                Container(
                  width: width,
                  height: height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: theme.inverseSurface),
                  ),
                  child: Stack(
                    children: [
                      // Display tags area
                      Positioned(
                        top: 10,
                        right: 10,
                        left: 10,
                        bottom: 60,
                        child: SingleChildScrollView(
                          child: _buildTagsDisplay(),
                        ),
                      ),
                      // Text field for adding new tags
                      Positioned(
                        bottom: 10,
                        right: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            controller: tagController,
                            textAlign: TextAlign.end,
                            cursorColor: const Color(0xff919296),
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: Color(0xff919296),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                color: Color(0xff919296),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                              errorStyle: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                              suffixIcon: IconButton(
                                onPressed: _addTag,
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                ),
                              ),
                              hintMaxLines: 1,
                              contentPadding: const EdgeInsets.only(
                                left: 14,
                                top: 0,
                                bottom: 0,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: _inputBorder,
                              enabledBorder: _inputBorder,
                              focusedBorder: _inputBorder,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextFieldArea(
                  hint: "التفاصيل",
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: theme.inverseSurface),
                  windowController: TextEditingController(),
                ),
                const SizedBox(height: 30),
                SizedBox(height: height * 0.1),
                CustomPrimaryButton(
                  text: 'نشر',
                  color: Theme.of(context).primaryColor,
                  ontap: () {
                    showDialog(
                      context: context,
                      builder: (context) => PolicyPage(),
                    );
                  },
                  height: height * 0.05,
                  width: width * 0.9,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
