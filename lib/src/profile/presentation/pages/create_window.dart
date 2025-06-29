import 'package:animate_do/animate_do.dart';
import 'package:buytx/src/home/widgets/customCircularButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../core/configs/assets/app_image.dart';
import '../widgets/more_button.dart';

class CreateWindow extends StatefulWidget {
  const CreateWindow({super.key});
  static String name = 'create_window';

  @override
  State<CreateWindow> createState() => _CreateWindowState();
}

class _CreateWindowState extends State<CreateWindow> {
  bool isClicked = true;
  final windowController = TextEditingController();
  final windowContentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            expandedHeight: height / 2.6,
            pinned: true,
            leadingWidth: double.maxFinite,
            floating: false,
            leading: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeInLeft(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.linearToEaseOut,
                    child: CustomSmallButton(
                      colorIcon: Colors.black,
                      colors: Colors.white,
                      icons: CupertinoIcons.back,
                      radius: 10,
                      onPressed: () {
                        context.pop();
                      },
                      size: 25,
                    ),
                  ),
                  FadeInLeft(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.linearToEaseOut,
                    child: CustomSmallButton(
                      colorIcon: Colors.black,
                      colors: Colors.white,
                      icons: Icons.more_vert,
                      radius: 10,
                      onPressed: () {},
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  _buildBg(height, width),
                  //-----
                  // _header(height, context, () {}, () {}),
                  _userImage(height, width),
                ],
              ),
            ),
          ),
          //=====
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 40),
                //this is the status of this account
                ZoomInDown(
                  duration: const Duration(milliseconds: 850),
                  child: Center(
                    child: Text(
                      "متصل",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                //this is the name of the user
                ZoomInDown(
                  duration: const Duration(milliseconds: 900),
                  child: Center(
                    child: Text(
                      "أغيد علوان",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                //this is the user tag
                ZoomInDown(
                  duration: const Duration(milliseconds: 950),
                  child: Center(
                    child: Text(
                      "@Aghiad _2Ex",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ZoomInDown(
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    "يمكنك إنشاءنوافذ خاصة بك التي ستعرف عن خدماتك و متجرك",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                SlideInRight(
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(
                      "اسم النافذة",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SlideInRight(
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Material(
                      child: CustomTextField(
                        windowController: windowController,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SlideInRight(
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(
                      "محتوى النافذة",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                SlideInRight(
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Material(
                      child: CustomTextFieldArea(
                        windowController: windowContentController,
                        hint: "اكتب تفاصيل النافذة",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: CustomPrimaryButton(
                    text: "إنشاء نافذة",
                    color: Theme.of(context).primaryColor,
                    height: height / 18,
                    width: width / 1.1,
                    ontap: () {},
                  ),
                ),
                const SizedBox(height: 400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _userImage(double height, double width) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ZoomInDown(
        duration: const Duration(milliseconds: 800),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const CircleAvatar(
            backgroundImage:
            //later we bring the image from the api
            AssetImage("assets/images/Rectangle.png"),
            radius: 70,
          ),
        ),
      ),
    );
  }

  //=========
  Widget _buildBg(double height, double width) {
    return SizedBox(
      height: height / 3,
      width: width,
      child: Image.asset(AppImage.profileBg, fit: BoxFit.fill),
    );
  }

  //=======
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.windowController});

  final TextEditingController windowController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: windowController,
      decoration: InputDecoration(
        hintText: "مثال عن المتجر",
        hintStyle: Theme.of(context).textTheme.bodySmall,
        hintTextDirection: TextDirection.rtl,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}

//======
class CustomTextFieldArea extends StatelessWidget {
  const CustomTextFieldArea({
    super.key,
    required this.windowController,
    required this.hint,
    this.hintStyle,
  });

  final TextEditingController windowController;
  final String hint;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: windowController,
      // maxLength: 4,
      maxLines: 6,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle ?? Theme.of(context).textTheme.bodySmall,
        hintTextDirection: TextDirection.rtl,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
