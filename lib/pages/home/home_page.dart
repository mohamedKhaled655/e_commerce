

import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/utills/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../account/account_page.dart';
import '../auth/sign_up_page.dart';
import '../cart/cart_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PersistentTabController _controller;

  int _selectedIndex=0;
  List pages=[
    MainFoodPage(),
    Container(child: Center(child: Text("page1")),),
    Container(child: Center(child: Text("page2")),),
    Container(child: Center(child: Text("page3")),),
  ];

  void onTabNav(int index){
   setState(() {
     _selectedIndex=index;
   });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }
  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
     // SignUpPage(),
      Container(child: Center(child: Text("page1")),),
      CartHistory(),
      AccountPage(),

    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary:AppColor.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox_fill),
        title: ("history"),
        activeColorPrimary: AppColor.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: ("cart"),
        activeColorPrimary: AppColor.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("me"),
        activeColorPrimary: AppColor.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

    ];
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: pages[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       showUnselectedLabels: false,
  //       showSelectedLabels: false,
  //       selectedItemColor: AppColor.mainColor,
  //       unselectedItemColor: Colors.amberAccent,
  //       selectedFontSize: 0,
  //       unselectedFontSize: 0,
  //
  //       currentIndex: _selectedIndex,
  //       onTap:onTabNav ,
  //       items: [
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.home,
  //               ),
  //           label: "Home",
  //         ),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.archive,
  //               ),
  //           label: "history",
  //         ),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.shopping_cart,
  //            ),
  //           label: "cart",
  //         ),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.person,
  //               ),
  //           label: "me",
  //         ),
  //       ],
  //     ),
  //   );
  // }
//////////////////

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

}
