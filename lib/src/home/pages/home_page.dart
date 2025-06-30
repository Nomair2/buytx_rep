// ignore_for_file: sized_box_for_whitespace

import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_bloc.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messsages_events.dart';
import 'package:buytx/src/filtering/presentaion/popuUp/filtering_popup.dart';
import 'package:buytx/src/filtering/presentaion/popuUp/popup2.dart';
import 'package:buytx/src/home/domain/products/bloc/products_bloc.dart';
import 'package:buytx/src/notification/presentation/pages/notification_page.dart';
import 'package:buytx/src/home/pages/side_bar.dart';
import 'package:buytx/src/verification/presentation/pages/verification_req_page.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:buytx/core/common/widgets/custom_choose_button.dart';
import 'package:buytx/core/common/widgets/product_card.dart';
import 'package:buytx/src/home/bloc/choose_bloc.dart';
import 'package:buytx/src/home/pages/detail_product_page.dart';
import 'package:buytx/src/home/widgets/bottom_nav_bar.dart';
import 'package:buytx/src/home/widgets/customCircularButton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const name = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool changeColor = false;
  final scrollContainer = ScrollController();
  final messageBloc = messagesBloc();
  bool showHeader = true;
  double _heightMarket = 100;
  double lastOffset = 0;

  @override
  void initState() {
    super.initState();
    context.read<messagesBloc>().add(MessagesLoadingEvent());
    context.read<ProductsBloc>().add(FetchProducts());
    WidgetsBinding.instance.addObserver(this);
    scrollContainer.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollContainer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      context.read<messagesBloc>().add(CloseEvent());
    } else if (state == AppLifecycleState.resumed) {
      context.read<messagesBloc>().add(MessagesLoadingEvent());
    }
  }

  onScroll() {
    if (scrollContainer.offset < 10) {
      setState(() {
        _heightMarket = 100;
      });
    } else {
      setState(() {
        _heightMarket = 50;
      });
    }
    lastOffset = scrollContainer.offset;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // context.read<messagesBloc>().add(MessagesLoadingEvent());
    return SafeArea(
      child: BlocProvider(
        create: (context) => ChooseBloc(),
        child: Scaffold(
          body: AnimatedContainer(
            duration: Duration(seconds: 1), // مدة التغيير
            curve: Curves.easeInOut, // منحنى الحركة
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  changeColor
                      ? Theme.of(context).secondaryHeaderColor
                      : Theme.of(context).primaryColor,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _appBar(),
                          SizedBox(height: size.height * 0.01),
                          _searching(context),
                          SizedBox(height: size.height * 0.01),
                          _products(context, size, changeColor),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  // bottom: 5,
                  alignment: Alignment.bottomCenter,
                  child: BottomNavBar(changeColor: changeColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      // padding: EdgeInsets.only(top: 50),
      constraints: BoxConstraints(minHeight: 50),
      height: _heightMarket,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  changeColor = false;
                });
              },
              child: Container(
                // height: _heightMarket,
                constraints: BoxConstraints(minWidth: 155),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  // color: colorsprimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(size: 30, Icons.autorenew, color: Colors.white),
                      SizedBox(width: 8),
                      Text('بازار', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  changeColor = true;
                });
              },
              child: Container(
                constraints: BoxConstraints(minWidth: 155),
                decoration: BoxDecoration(
                  color: Color(0xff12ADD8),
                  // color: colorsprimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        size: 30,
                        Icons.shopify_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text('ماركت', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _products(BuildContext context, Size size, bool changeColor) {
    return Expanded(
      child: NestedScrollView(
        controller: scrollContainer,
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: const Color(0xffffffff).withOpacity(0),
                leadingWidth: double.maxFinite,
                flexibleSpace: _categories(context, size, changeColor),
              ),
            ],
        body: BlocConsumer<ProductsBloc, ProductsState>(
          listener: (context, state) {
            print(state);
          },
          builder: (context, state) {
            if (state is ProductsReady) {
              return GridView.builder(
                padding: EdgeInsets.only(bottom: size.height * 0.08),
                physics: const AlwaysScrollableScrollPhysics(),

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 3
                          : 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio:
                      MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 0.85
                          : 0.6,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print(state.products[index].value.toJson());
                      context.pushNamed(
                        "detail",
                        extra: state.products[index].value.id,
                      );
                    },
                    child: ProductCard(
                      changeColor: changeColor,
                      imagePath:
                          state.products[index].value.images.first.high ?? "",
                      location: state.products[index].value.location.details,
                      nameOwner:
                          state.products[index].value.owner ?? "غير محدد",
                      nameProduct: state.products[index].value.title,
                      price: state.products[index].value.price.toString(),
                      timing: state.products[index].value.quantity.toString(),
                    ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _categories(BuildContext context, Size size, bool changeColor) {
    List<String> items = ["عقارات للبيع", 'عقارات للأجار'];
    return BlocBuilder<ChooseBloc, int>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.keyboard_double_arrow_left_rounded,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            Expanded(
              flex: 2,
              child: CustomChooseHomeButton(
                ontap: () {
                  context.read<ChooseBloc>().changeIndex(0);
                },
                changeColor: changeColor,
                isChoosed: state == 0,
                // flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PopupMenuButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                      ),
                      itemBuilder:
                          (context) =>
                              items.map((String item) {
                                return PopupMenuItem<String>(
                                  value: item,

                                  child: Center(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                    ),
                    const Text('عقارات'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: CustomChooseHomeButton(
                ontap: () => context.read<ChooseBloc>().changeIndex(1),
                changeColor: changeColor,
                isChoosed: state == 1,
                // flex: 1,
                child: Text('سيارات'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: CustomChooseHomeButton(
                changeColor: changeColor,
                isChoosed: state == 2,
                // flex: 1,
                ontap: () => context.read<ChooseBloc>().changeIndex(2),
                child: const Text('هواتف'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _searching(BuildContext context) {
    return Row(
      children: [
        CustomSmallButton(
          colorIcon: Theme.of(context).colorScheme.onSecondary,
          colors: Theme.of(context).colorScheme.primaryContainer,
          icons: Icons.notifications_outlined,
          onPressed: () => context.pushNamed(NotificationPage.name),
          radius: 8,
          size: 30,
        ),
        const SizedBox(width: 10),
        CustomSmallButton(
          colorIcon: Theme.of(context).colorScheme.onSecondary,
          colors: Theme.of(context).colorScheme.primaryContainer,
          icons: Icons.tune,
          onPressed: () {
            showDialog(context: context, builder: (context) => Popup2());
          },
          radius: 8,
          size: 30,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            // width: size.width,
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: const Offset(0, 6),
                  spreadRadius: -1,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(18),
            ),
            child: TextFormField(
              // validator: validate,
              controller: TextEditingController(),
              keyboardType: TextInputType.emailAddress,
              readOnly: true,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              decoration: InputDecoration(
                hintText: 'BUYTX أبحث في ',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                border: InputBorder.none,
                suffixIcon: Icon(
                  // Ionicons.ios_search,
                  CupertinoIcons.search,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        CustomSmallButton(
          colorIcon: Theme.of(context).colorScheme.onSecondary,
          colors: Theme.of(context).colorScheme.primaryContainer,
          icons: Icons.segment,
          onPressed: () {
            showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(0.3),
              builder:
                  (context) => Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 300, // Match the width in your SideBar widget
                      child: SideBar(),
                    ),
                  ),
            );
          },
          radius: 8,
          size: 30,
        ),
      ],
    );
  }
}
