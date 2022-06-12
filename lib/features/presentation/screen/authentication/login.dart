import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zenfoodapp/core/dependencies/app_dependencies.dart';
import 'package:zenfoodapp/core/utils/validate_utils.dart';
import 'package:zenfoodapp/features/presentation/bloc/login/login_bloc.dart';
import 'package:zenfoodapp/features/presentation/bloc/login/login_event.dart';
import 'package:zenfoodapp/features/presentation/bloc/login/login_state.dart';
import 'package:zenfoodapp/features/presentation/screen/authentication/register.dart';
import 'package:zenfoodapp/main.dart';

import '../../widget/custom_text_field.dart';
import 'forgotpassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  late LoginBloc _loginBloc;
  StreamSubscription<LoginState>? _streamSubscription;

  @override
  initState() {
    super.initState();
    _loginBloc = AppDependencies.injector.get<LoginBloc>();
    _streamSubscription = _loginBloc.stream.listen((state) {
      if (state is LoginSuccessState) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
      if (state is LoginFailState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please login again!')),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 100),
            child: Text(
              'LOGIN',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Form(
              key: _formKey,
              child: SizedBox(
                height: 370,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      title: 'Email',
                      errorText: 'Please enter a valid email address',
                      hint: 'Enter your email address',
                      validator: (value) => ValidateUtils()
                          .checkRegex(ValidateUtils().email, value),
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      title: 'PASSWORD',
                      obscureText: true,
                      errorText: 'Please enter a valid password',
                      hint: 'Enter your password',
                      validator: (value) => ValidateUtils()
                          .checkRegex(ValidateUtils().password, value),
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()),
                            );
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
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
                            _loginBloc.add(RequestLoginEvent(
                                emailController.text, passwordController.text));
                          }
                        },
                        child: const Text('LOGIN'),
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
                                text: 'Don\'t have an account?',
                              ),
                              TextSpan(
                                  text: ' Register',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen()),
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
        ],
      ),
    ));
  }
}

class _TransitionListTile extends StatelessWidget {
  const _TransitionListTile({
    this.onTap,
    required this.title,
    required this.subtitle,
  });

  final GestureTapCallback? onTap;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      leading: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.black54,
          ),
        ),
        child: const Icon(
          Icons.play_arrow,
          size: 35,
        ),
      ),
      onTap: onTap,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
