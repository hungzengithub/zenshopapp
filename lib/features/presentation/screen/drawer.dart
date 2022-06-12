import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zenfoodapp/core/dependencies/app_dependencies.dart';
import 'package:zenfoodapp/core/global/global.dart';
import 'package:zenfoodapp/features/presentation/bloc/login/login_bloc.dart';
import 'package:zenfoodapp/features/presentation/bloc/login/login_state.dart';
import 'package:zenfoodapp/features/presentation/screen/authentication/login.dart';

import '../widget/button/progress_button.dart';
import '../widget/drawer/drawer_menu_item.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late LoginBloc _loginBloc;
  StreamSubscription<LoginState>? _streamSubscription;
  @override
  initState() {
    super.initState();
    _loginBloc = AppDependencies.injector.get<LoginBloc>();
    _streamSubscription = _loginBloc.stream.listen((state) {
      if (state is LogoutSuccessState) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
      if (state is LogoutFailState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout failed. Please logout again!')),
        );
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    _loginBloc.close();
    _streamSubscription?.cancel();
  }

  ButtonState stateOnlyText = ButtonState.idle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xffadffe4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
              children: const [
                CircleAvatar(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'James',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 160,
          ),
          DrawerMenuItem(
            icon: Icons.straighten_outlined,
            buttonText: 'Button',
            onPressed: () {},
          ),
          DrawerMenuItem(
            icon: Icons.rtt,
            buttonText: 'TextField',
            onPressed: () {},
          ),
          DrawerMenuItem(
            icon: Icons.tungsten_outlined,
            buttonText: 'Tips',
            onPressed: () {},
          ),
          DrawerMenuItem(
            icon: Icons.hourglass_bottom_outlined,
            buttonText: 'Bottom Bar',
            onPressed: () {},
          ),
          DrawerMenuItem(
            icon: Icons.star_outline_sharp,
            onPressed: () {
              firebaseAuth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const LoginScreen()));
              });
            },
            buttonText: 'Other',
          ),
        ],
      ),
    );
  }
}
