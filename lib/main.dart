import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenfoodapp/core/utils/appcolors.dart';
import 'package:zenfoodapp/features/presentation/screen/authentication/login.dart';
import 'package:zenfoodapp/features/presentation/screen/drawer.dart';
import 'package:zenfoodapp/features/presentation/screen/home.dart';

import 'core/global/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff9fffc),
        body: Stack(
          children: [
            const CustomDrawer(),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.buttonColorAdding,
                  borderRadius: BorderRadius.circular(40)),
              transform: Matrix4.translationValues(210, 180, 0)
                ..scale(0.5)
                ..rotateY(-0.5),
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xffe0e0e0),
                  borderRadius: BorderRadius.circular(40)),
              transform: Matrix4.translationValues(220, 170, 0)
                ..scale(0.55)
                ..rotateY(-0.5),
            ),
            const HomeScreen(),
          ],
        ),
      ),
    );
  }
}
