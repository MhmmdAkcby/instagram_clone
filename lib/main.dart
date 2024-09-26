import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/products/utils/colors.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAB-xwXuNiNcdHPd5-VIykTnKXwVQo7cpk",
        appId: "1:941206901399:web:841ec187f782d811b64fd2",
        messagingSenderId: "941206901399",
        projectId: "instagram-tut-b9d62",
        storageBucket: "instagram-tut-b9d62.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   webScreenLayout: WebScreenLayout(),
      //   mobileScreenLayout: MobileScreenLayout(),
      // ),
      home: const LoginScreen(),
    );
  }
}
