import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_life/utils/colors.dart';
import 'package:new_life/utils/global_variables.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/change_theme_button_widget.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: width > webScreenSize
          ? webBackgroundColor
          : Theme.of(context).scaffoldBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              elevation: 0,
              bottom: PreferredSize(
                  child: Container(
                    color: Colors.white.withOpacity(0.2),
                    height: 1.0,
                  ),
                  preferredSize: Size.fromHeight(1.0)),
              backgroundColor: Colors.black54.withOpacity(0.8),
              //centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/NewLife.svg",
                    //color: Theme.of(context).primaryColor,
                    height: 32,
                  ),
                  SizedBox(
                    width: 85,
                  ),
                  Center(
                      child: Text("  Home",
                          style: TextStyle(
                              fontFamily: 'Nutino',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25))),
                ],
              ),
              actions: [const ChangeThemeButtonWidget(), SizedBox(width: 10)],
            ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width > webScreenSize ? width * 0.3 : 0,
                    vertical: width > webScreenSize ? 10 : 0,
                  ),
                  child: PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              );
            } else {
              return Container(child: Center(child: Text("No Feed To Show")));
            }
          }),
    );
  }
}
