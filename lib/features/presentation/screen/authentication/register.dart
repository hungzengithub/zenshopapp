// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenfoodapp/core/dependencies/app_dependencies.dart';
import 'package:zenfoodapp/core/utils/validate_utils.dart';
import 'package:zenfoodapp/features/domain/entities/account.dart';
import 'package:zenfoodapp/features/presentation/bloc/signup/signup_bloc.dart';
import 'package:zenfoodapp/features/presentation/bloc/signup/signup_event.dart';
import 'package:zenfoodapp/features/presentation/bloc/signup/signup_state.dart';
import 'package:zenfoodapp/features/presentation/screen/authentication/login.dart';

import '../../widget/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  late SignupBloc _signupBloc;
  StreamSubscription<SignupState>? _streamSubscription;

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  Position? position;

  @override
  initState() {
    super.initState();
    _signupBloc = AppDependencies.injector.get<SignupBloc>();
    _streamSubscription = _signupBloc.stream.listen((state) {
      if (state is GetLocationSuccess) {
        setState(() {
          locationController.text = state.position.address;
          position = state.position.position;
        });
      }
      if (state is GetImageSuccess) {
        setState(() {
          imageXFile = state.image;
        });
      }
      if (state is SignupSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup success. Please login!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
      if (state is SignupFail) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup Fail')),
        );
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    _signupBloc.close();
    _streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: SizedBox(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 20, top: 20),
                    child: Text(
                      'REGISTER',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        _signupBloc.add(PickupImageEvent(_picker));
                      },
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.15,
                        backgroundColor: const Color(0xffF4F4F4),
                        backgroundImage: imageXFile == null
                            ? null
                            : FileImage(File(imageXFile!.path)),
                        child: imageXFile == null
                            ? Icon(
                                Icons.camera,
                                size: MediaQuery.of(context).size.width * 0.1,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    title: 'FULLNAME',
                    hint: 'Enter your username',
                    errorText: 'Please enter a valid username',
                    validator: (value) {
                      return true;
                    },
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    title: 'EMAIL',
                    errorText: 'Please enter a valid email address',
                    hint: 'Enter your email',
                    validator: (value) => ValidateUtils()
                        .checkRegex(ValidateUtils().email, value),
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    title: 'PHONE',
                    errorText: 'Please enter a phone number',
                    hint: 'Enter your phone number',
                    validator: (value) => ValidateUtils()
                        .checkRegex(ValidateUtils().phone, value),
                    controller: phoneController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    title: 'PASSWORD',
                    errorText: 'Please enter a valid password',
                    hint: 'Enter your password',
                    obscureText: true,
                    validator: (value) => ValidateUtils()
                        .checkRegex(ValidateUtils().password, value),
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    title: 'CONFIRM PASSWORD',
                    errorText: 'Your confirm password is not match',
                    hint: 'Enter your confirm password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          confirmPasswordController.text !=
                              passwordController.text) {
                        return false;
                      } else {
                        return true;
                      }
                    },
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    title: 'LOCATION',
                    hint: 'Enter your location',
                    errorText: 'Please enter a valid location',
                    validator: (value) {
                      return true;
                    },
                    controller: locationController,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 10),
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xfffc6e3b),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        _signupBloc.add(GetLocationEvent());
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(Icons.location_pin),
                            Text('GET LOCATION')
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xff2FDBBC),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          var account = Account(
                              fullname: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                              location: locationController.text,
                              imageURL: imageXFile!.path.toString(),
                              position: position);
                          _signupBloc.add(RequestSignupEvent(account));
                        }
                      },
                      child: const Text('REGISTER'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color(0xffA3A3A3),
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Already have an account?',
                            ),
                            TextSpan(
                                text: ' Login',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()),
                                    );
                                  },
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.amber)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
