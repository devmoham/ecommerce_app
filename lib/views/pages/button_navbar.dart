import 'package:ecommerce_app/utills/app_color.dart';
import 'package:ecommerce_app/views/pages/cart.dart';
import 'package:ecommerce_app/views/pages/favorites_page.dart';
import 'package:ecommerce_app/views/pages/home.dart';
import 'package:ecommerce_app/views/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomButtonNavBar extends StatefulWidget {
  @override
  _CustomButtonNavBarState createState() => _CustomButtonNavBarState();
}

class _CustomButtonNavBarState extends State<CustomButtonNavBar> {
  late PersistentTabController _controller;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens(BuildContext context) {
    return [
      const Home(),
      const CartPage(),
      const FavoritesPage(),
      const SettingsPage(),
    ];
  }

  List<ItemConfig> _navBarsItems() {
    return [
      ItemConfig(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        // activeColorPrimary: Colors.deepPurple,
        // inactiveColorPrimary: Colors.grey,
      ),
      ItemConfig(
        icon: const Icon(CupertinoIcons.cart),
        title: ("Cart"),
        // activeColorPrimary: Colors.deepPurple,
        // inactiveColorPrimary: Colors.grey,
      ),
      ItemConfig(
        icon: const Icon(CupertinoIcons.heart),
        title: ("Favorites"),
        // activeColorPrimary: Colors.deepPurple,
        // inactiveColorPrimary: Colors.grey,
      ),
      ItemConfig(
        icon: const Icon(CupertinoIcons.person),
        title: ("Profile"),
        // activeColorPrimary: Colors.deepPurple,
        // inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(
              'assets/images/mohamed.jpg',
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mohamed Mostafa',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Let\'s go shopping',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          if (currentIndex == 0) ...[
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            const SizedBox(
              width: 10,
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
            const SizedBox(
              width: 10,
            )
          ] else
            IconButton(
                onPressed: () {}, icon: const Icon(CupertinoIcons.bag_fill)),
        ],
      ),
      body: PersistentTabView(
        controller: _controller,
        tabs: [
          PersistentTabConfig(
            item: _navBarsItems()[0],
            screen: _buildScreens(context)[0],
          ),
          PersistentTabConfig(
            item: _navBarsItems()[1],
            screen: _buildScreens(context)[1],
          ),
          PersistentTabConfig(
            item: _navBarsItems()[2],
            screen: _buildScreens(context)[2],
          ),
          PersistentTabConfig(
            item: _navBarsItems()[3],
            screen: _buildScreens(context)[3],
          ),
        ],
        navBarBuilder: (navbarConfig) => Style1BottomNavBar(
          navBarConfig: navbarConfig,
        ),
        onTabChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: AppColors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: false, // Default is true.
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
      ),
    );
  }
}
