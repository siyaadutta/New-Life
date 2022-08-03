import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_life/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Using Provider: It will make just one call to Database that's why useful.
    // userModel.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.black54.withOpacity(0.8),
        activeColor: Colors.white,
        inactiveColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: SvgPicture.asset(
              "assets/home.svg",
              height: 30.0,
              width: 30.0,
              allowDrawingOutsideViewBox: true,
            ),
            //backgroundColor: Theme.of(context).primaryColor
          ),
          BottomNavigationBarItem(
              label: "Search",
              icon: SvgPicture.asset(
                "assets/search.svg",
                height: 30.0,
                width: 30.0,
                allowDrawingOutsideViewBox: true,
              ),
              backgroundColor: Theme.of(context).primaryColor),
          BottomNavigationBarItem(
              label: "Upload",
              icon: SvgPicture.asset(
                "assets/add.svg",
                height: 30.0,
                width: 30.0,
                allowDrawingOutsideViewBox: true,
              ),
              backgroundColor: Theme.of(context).primaryColor),
          BottomNavigationBarItem(
              label: "Chat",
              icon: SvgPicture.asset(
                "assets/Chat_5.svg",
                height: 30.0,
                width: 30.0,
                allowDrawingOutsideViewBox: true,
              ),
              backgroundColor: Theme.of(context).primaryColor),
          BottomNavigationBarItem(
              label: "Profile",
              icon: SvgPicture.asset(
                "assets/Profile.svg",
                height: 30.0,
                width: 30.0,
                color: Theme.of(context).primaryColor,
                allowDrawingOutsideViewBox: true,
              ),

              backgroundColor: Theme.of(context).primaryColor),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
