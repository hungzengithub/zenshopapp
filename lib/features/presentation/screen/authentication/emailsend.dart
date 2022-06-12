import 'package:flutter/material.dart';
import 'package:zenfoodapp/core/utils/appcolors.dart';
import 'package:zenfoodapp/features/presentation/screen/authentication/login.dart';

class EmailSendScreen extends StatefulWidget {
  const EmailSendScreen({Key? key}) : super(key: key);

  @override
  _EmailSendScreenState createState() => _EmailSendScreenState();
}

class _EmailSendScreenState extends State<EmailSendScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'EMAIL SENT',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xffA3A3A3),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'We’ve sent you an email at',
                      ),
                      TextSpan(
                          text: ' user@email.com',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.buttonColorAdding)),
                      TextSpan(
                        text:
                            ' for verification. Check your email for the verification link.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text('00 : 38',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.amber)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text('Did not receive the email yet?',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text('Resend',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.buttonColorAdding)),
                  ),
                  const SizedBox(
                    height: 40,
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text('RESET PASSWORD'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
