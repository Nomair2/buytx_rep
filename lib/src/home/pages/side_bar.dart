import 'package:buytx/core/configs/assets/app_image.dart';
import 'package:buytx/src/notification/presentation/pages/notification_page.dart';
import 'package:buytx/src/verification/presentation/pages/verification_req_page.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buytx/core/configs/theme/theme_cubit.dart';
import 'package:go_router/go_router.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool settingsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surfaceContainer.w,
      body: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainer.withOpacity(0.35),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back arrow
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    // Profile
                    Center(
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 32,
                            backgroundImage: AssetImage(AppImage.psersonImage),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'أحمد علوان',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '@Ahjad_2Ex',
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 140,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              iconAlignment: IconAlignment.end,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 25,
                              ),
                              label: const Text(
                                'إضافة عرض',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Menu items
                    Opacity(
                      opacity: 0.4,
                      child: Divider(
                        thickness: 2,
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.onSecondary.withValues(),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            Icons.shopping_bag_outlined,
                            'منتجاتي',
                          ),
                          _buildMenuItem(Icons.chat, 'الرسائل'),
                          _buildMenuItem(
                            Icons.notifications_none,
                            'الإشعارات',
                            ontap:
                                () => context.pushNamed(NotificationPage.name),
                          ),
                        ],
                      ),
                    ),
                    Opacity(
                      opacity: 0.4,
                      child: Divider(
                        thickness: 2,
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.onSecondary.withValues(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          _buildMenuItem(Icons.favorite_border, 'المفضلة'),
                          _buildMenuItem(
                            Icons.person_add_alt_sharp,
                            'المتابعين',
                          ),
                          _buildMenuItem(
                            Icons.verified,
                            'توثيق الحساب',
                            ontap:
                                () =>
                                    context.pushNamed(VerificationReqPage.name),
                          ),
                        ],
                      ),
                    ),
                    Opacity(
                      opacity: 0.4,
                      child: Divider(
                        thickness: 2,
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.onSecondary.withValues(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            Icons.headset_mic_outlined,
                            'فريق الدعم',
                          ),
                          _buildMenuItem(
                            Icons.policy_outlined,
                            'سياسة تطبيق BUYTX',
                          ),
                          _buildMenuItem(Icons.security_outlined, 'مركز أمان'),
                        ],
                      ),
                    ),
                    Opacity(
                      opacity: 0.4,
                      child: Divider(
                        thickness: 2,
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.onSecondary.withValues(),
                      ),
                    ),
                    // Night mode toggle
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Column(
                        children: [
                          BlocBuilder<ThemeCubit, ThemeMode>(
                            builder: (context, themeMode) {
                              final isDarkMode = themeMode == ThemeMode.dark;
                              return Row(
                                children: [
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 400),
                                    transitionBuilder:
                                        (child, animation) =>
                                            RotationTransition(
                                              turns: animation,
                                              child: child,
                                            ),
                                    child: Icon(
                                      isDarkMode
                                          ? Icons.nightlight_round
                                          : Icons.wb_sunny,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.primaryFixed,
                                      key: ValueKey<bool>(isDarkMode),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Text(
                                    'الوضع الليلي',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Switch(
                                    value: isDarkMode,
                                    activeColor: Colors.white,
                                    onChanged: (val) {
                                      context.read<ThemeCubit>().toggleTheme();
                                    },
                                    activeTrackColor: const Color(0xFF8BC34A),
                                    inactiveTrackColor: Colors.grey,
                                    inactiveThumbColor: Colors.white,
                                    hoverColor: Colors.grey[300],
                                  ),
                                ],
                              );
                            },
                          ),
                          // Settings Expansion
                          Theme(
                            data: Theme.of(
                              context,
                            ).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.all(0),
                              title: Row(
                                children: [
                                  // const SizedBox(width: 14),
                                  Text(
                                    'إعدادات',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 400),
                                    transitionBuilder:
                                        (child, animation) =>
                                            RotationTransition(
                                              turns: animation,
                                              child: child,
                                            ),
                                    child: Icon(
                                      settingsExpanded
                                          ? Icons.keyboard_arrow_up_outlined
                                          : Icons.keyboard_arrow_down_outlined,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.primaryFixed,
                                    ),
                                  ),
                                ],
                              ),
                              leading: Icon(
                                Icons.apps_outlined,
                                color:
                                    Theme.of(context).colorScheme.primaryFixed,
                              ),
                              trailing: SizedBox.shrink(),
                              initiallyExpanded: settingsExpanded,
                              onExpansionChanged: (expanded) {
                                setState(() {
                                  settingsExpanded = expanded;
                                });
                              },
                              childrenPadding: EdgeInsets.only(right: 20),
                              children: [
                                ListTile(
                                  title: Text(
                                    'معلوماتي الشخصية',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                                ListTile(
                                  title: Text(
                                    'تعديل معلوماتي الشخصية',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                                ListTile(
                                  title: Text(
                                    'حذف حسابي',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          // Logout
                          ListTile(
                            leading: const Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            title: const Text(
                              'تسجيل الخروج',
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Opacity(
                      opacity: 0.4,
                      child: Divider(
                        thickness: 2,
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.onSecondary.withValues(),
                      ),
                    ),

                    // Version
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'V0.1',
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'BUYTX©2025',
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, {void Function()? ontap}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primaryFixed),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      onTap: ontap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      dense: true,
    );
  }
}
