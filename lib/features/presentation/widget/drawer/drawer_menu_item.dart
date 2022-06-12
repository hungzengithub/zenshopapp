import 'package:flutter/material.dart';

class DrawerMenuItem extends StatefulWidget {
  final IconData icon;
  final String buttonText;
  final Function onPressed;
  const DrawerMenuItem(
      {Key? key,
      required this.icon,
      required this.buttonText,
      required this.onPressed})
      : super(key: key);
  @override
  _DrawerMenuItemState createState() => _DrawerMenuItemState();
}

class _DrawerMenuItemState extends State<DrawerMenuItem> {
  var isTap = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        widget.onPressed();
      },
      child: AnimatedContainer(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.only(left: 10),
        margin: const EdgeInsets.only(bottom: 20),
        duration: const Duration(milliseconds: 250),
        width: 250,
        height: 40,
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 28,
              color: Colors.black.withOpacity(0.7),
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              widget.buttonText,
              style:
                  TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
