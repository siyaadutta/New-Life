import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_life/providers/user_provider.dart';
import 'package:new_life/responsive/mobile_screen_layout.dart';
import 'package:new_life/responsive/responsive_layout_screen.dart';
import 'package:new_life/responsive/web_screen_layout.dart';
import 'package:new_life/screens/login_screen.dart';
import 'package:new_life/utils/colors.dart';
import 'package:new_life/utils/my_theme.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
         apiKey: "AIzaSyC03qDM2E-jH1qUh4FA4whp1jyZjq1QkKY",
        appId: "1:366640933032:web:5d891e12bbfbe9d31aba9d",
        messagingSenderId: "366640933032",
        projectId: "new-life-cba33",
        storageBucket: "new-life-cba33.appspot.com",)
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider())
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'New Life',
            themeMode: themeProvider.themeMode,
            theme: MyTheme.lightTheme(),
            darkTheme: MyTheme.darkTheme(),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const ResponsiveLayout(
                        webScreenLayout: WebSreenLayout(),
                        mobileScreenLayout: MobileScreenLayout());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }

                return const LoginScreen();
              },
            ));
      },
    );
  }
}
