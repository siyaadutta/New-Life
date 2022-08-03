import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_life/screens/add_post_screen.dart';
import 'package:new_life/screens/feed_screen.dart';
import 'package:new_life/screens/profile_screen.dart';
import 'package:new_life/screens/search_screen.dart';
import 'package:new_life/screens/ChatScreen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  ChatScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
