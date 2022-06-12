import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final bool Function(String?) validator;
  final String errorText;

  const CustomTextField({
    Key? key,
    required this.title,
    required this.hint,
    required this.validator,
    required this.controller,
    required this.errorText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late Color currentColor;
  late String? errorText = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40.0, bottom: 5),
          child: Text(
            widget.title,
            style: const TextStyle(
                color: Color(0xff2FDBBC),
                fontWeight: FontWeight.w600,
                fontSize: 12),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 5, right: 20),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.only(left: 12),
            child: TextFormField(
              obscureText: widget.obscureText,
              controller: widget.controller,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !widget.validator(value)) {
                  setState(() {
                    errorText = widget.errorText;
                  });
                  return errorText;
                } else {
                  setState(() {
                    errorText = '';
                  });
                  return null;
                }
              },
              onTap: () {
                setState(() {
                  errorText = '';
                });
              },
              decoration: InputDecoration(
                // ignore: unnecessary_null_comparison
                hintText: errorText == '' ? widget.hint : null,
                border: InputBorder.none,
                fillColor: Colors.white,

                errorStyle: const TextStyle(fontSize: 9, height: 0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
