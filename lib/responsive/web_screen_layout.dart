import 'package:flutter/material.dart';
import 'package:new_life/utils/global_variables.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';

class WebSreenLayout extends StatefulWidget {
  const WebSreenLayout({Key? key}) : super(key: key);

  @override
  State<WebSreenLayout> createState() => _WebSreenLayoutState();
}

class _WebSreenLayoutState extends State<WebSreenLayout> {
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
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode?Colors.black54:Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode?Colors.black:Colors.white.withOpacity(0.5),
        centerTitle: false,
        title: Row(
          children: [

            SvgPicture.asset(
            "assets/NewLife.svg",
            // color: primaryColor,
            height: 50,
          ),
        !isDarkMode?Image.asset('assets/NewLifeTextDark.png',width: 80,):Image.asset('assets/NewLifeText.png',width: 80,),
            ]
        ),
        actions: [
          IconButton(
            onPressed: () => navigationTapped(0),
            icon: SvgPicture.asset(
              "assets/home.svg",
              height: 100.0,
              width: 100.0,
              //allowDrawingOutsideViewBox: true,
            ),
          ),
          SizedBox(width: 20,),
          IconButton(
            onPressed: () => navigationTapped(1),
            iconSize: 25,
              icon:Image.asset('assets/search.png')
            //Icon(Icons.search_sharp,color: Colors.deepOrangeAccent,)

            //   (
            //   "assets/search.svg",
            //   height: 50.0,
            //   width: 50.0,
            //   allowDrawingOutsideViewBox: true,
            // ),
          ),
          SizedBox(width: 20,),
          IconButton(
            onPressed: () => navigationTapped(2),
              iconSize: 20,
              icon:Image.asset('assets/upload.png')
            // icon: SvgPicture.asset(
            //   "assets/add.svg",
            //   height: 50.0,
            //   width: 50.0,
            //   allowDrawingOutsideViewBox: true,
            // ),
          ),
          SizedBox(width: 20,),
          IconButton(
            onPressed: () => navigationTapped(3),
              iconSize: 20,
              icon:Image.asset('assets/msg.png')
            // icon: SvgPicture.asset(
            //   "assets/Chat_5.svg",
            //   height: 50.0,
            //   width: 50.0,
            //   allowDrawingOutsideViewBox: true,
            // ),
          ),
          SizedBox(width: 20,),
          IconButton(
            onPressed: () => navigationTapped(4),
              iconSize: 25,
              icon:Image.asset('assets/profile.png')
            // icon: SvgPicture.asset(
            //   "assets/Profile.svg",
            //   height: 30.0,
            //   width: 30.0,
            //   color: Theme.of(context).primaryColor,
            //   allowDrawingOutsideViewBox: true,
            // ),
          ),
          SizedBox(width: 20,),
        ],
      ),
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          children: homeScreenItems,
          controller: pageController,
          onPageChanged: onPageChanged),
    );
  }
}
