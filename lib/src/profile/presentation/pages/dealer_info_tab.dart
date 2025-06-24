// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:buytx/src/profile/presentation/pages/create_window.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/widgets/custom_primary_button.dart';
import '../widgets/inapp_info_tile.dart';

class DealerInfoTab extends StatefulWidget {
  const DealerInfoTab({super.key});

  @override
  State<DealerInfoTab> createState() => _DealerInfoTabState();
}

class _DealerInfoTabState extends State<DealerInfoTab> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Material(
          child: ZoomInDown(
            // delay: Duration(milliseconds: 1000),
            duration: const Duration(milliseconds: 1000),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InappInfoTile(
                  title: "المتابعين",
                  value: "350",
                  onTap: () {
                    context.pushNamed('follwer_page', extra: 0);
                  },
                ),
                InappInfoTile(
                  title: "يتابع",
                  value: "150",
                  onTap: () {
                    context.pushNamed('follwer_page', extra: 1);
                  },
                ),
                InappInfoTile(title: "المبيعات", value: "50", onTap: () {}),
              ],
            ),
          ),
        ),
        const SizedBox(height: 35),
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: SlideInRight(
            curve: Curves.linearToEaseOut,
            child: Text(
              "السيرة الذاتية",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        const SizedBox(height: 35),
        ZoomIn(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          child: Text(
            "تاجر محترف وموثوق، متخصص في بيع القطع الإلكترونية، مع التزام بتقديم جودة عالية، أسعار تنافسية، وخدمة عملاء مميزة. وأحرص على رضا العملاء.",
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),
        const AnimatedDivider(),
        UserInfoCell(
          title: "الأسم الكامل",
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 17,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Text("اغيد علوان", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const AnimatedDivider(),
        UserInfoCell(
          title: "البريد الإلكتروني",
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 17,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Text(
                "aghiad@gmail.com",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedDivider(),
        UserInfoCell(
          title: "كلمة السر",
          child: Row(
            children: [
              Material(
                child: InkWell(
                  onTap: () => context.push('/edit_password'),
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 17,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Text("مشفرة", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedDivider(),
        UserInfoCell(
          title: "اسم المستخدم",
          child: Row(
            children: [
              Material(
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 17,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Text(
                "@Aghiad _2Ex",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedDivider(),
        UserInfoCell(
          title: "الهاتف",
          child: Row(
            children: [
              Material(
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 17,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Text("9639855122", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedDivider(),
        UserInfoCell(
          title: "حالة الهاتف",
          child: Row(
            children: [
              Material(
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 17,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Text("ظاهر", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedDivider(),
        UserInfoCell(
          title: "الحساب",
          child: InfoStatusBtn(text: "نشط", onPressed: () {}),
        ),
        const SizedBox(height: 2),
        const AnimatedDivider(),
        UserInfoCell(
          title: "التحذيرات",
          child: Row(
            children: [
              Material(
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 17,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Text("0", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedDivider(),
        UserInfoCell(
          title: "حالة الحساب",
          child: InfoStatusBtn(text: "فعال", onPressed: () {}),
        ),
        const SizedBox(height: 2),
        const AnimatedDivider(),
        UserInfoCell(
          title: "نوع الحساب",
          child: Row(
            children: [
              Material(
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                    size: 17,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Text("عادي", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedDivider(),
        UserInfoCell(
          title: "التقييم",
          child: Row(
            children: [
              Text("9.5 تقييم", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(width: 3),
              Icon(Icons.star, color: Theme.of(context).primaryColor, size: 17),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const AnimatedDivider(),
        UserInfoCell(
          title: "المستخدمين المحظورين",
          child: Text("0", style: Theme.of(context).textTheme.bodySmall),
        ),
        const SizedBox(height: 10),
        const AnimatedDivider(),
        UserInfoCell(
          title: "تاريخ الدخول",
          child: Text("2025-03", style: Theme.of(context).textTheme.bodySmall),
        ),
        const SizedBox(height: 10),
        const AnimatedDivider(),
        const SizedBox(height: 30),
        Center(
          child: CustomPrimaryButton(
            text: "إنشاء نافذة",
            color: Theme.of(context).primaryColor,
            height: height / 18,
            width: width / 1.1,
            ontap: () => context.pushNamed(CreateWindow.name),
          ),
        ),
        const SizedBox(height: 300),
      ],
    );
  }
}

class AnimatedDivider extends StatelessWidget {
  const AnimatedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      child: Divider(
        color: Theme.of(context).colorScheme.inversePrimary,
        endIndent: 5,
        indent: 5,
      ),
    );
  }
}

class InfoStatusBtn extends StatelessWidget {
  InfoStatusBtn({super.key, required this.text, this.onPressed});
  Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      child: Text(text),
    );
  }
}

class UserInfoCell extends StatelessWidget {
  const UserInfoCell({super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeInLeftBig(
            duration: const Duration(milliseconds: 800),
            curve: Curves.linearToEaseOut,
            child: child,
          ),
          FadeInRightBig(
            duration: const Duration(milliseconds: 800),
            curve: Curves.linearToEaseOut,
            child: Text(title, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
