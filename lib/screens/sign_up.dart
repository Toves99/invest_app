import 'package:flutter/material.dart';
import 'package:invest_app/screens/Login_page.dart';
import 'package:invest_app/screens/create_account.dart';
import 'package:invest_app/widgets/custom_text_button.dart';
import 'package:invest_app/widgets/text__widget.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Image.asset('assets/invest.png', height: 140, width: 500),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, top: 10),
              child: CustomText(
                  text: "Stay on top of your\n   finance with us.",
                  size: 26,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, top: 10),
              child: CustomText(
                  text:
                      "    We are your financial advisor \nto recommend the best investiment for \n                           you.",
                  size: 15,
                  color: const Color.fromARGB(255, 114, 112, 112),
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: MaterialButton(
                minWidth: double.infinity,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignPage()),
                  );
                },
                color: Colors.blue,
                height: 40,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Create account',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: CustomTextButton(
                text: 'Login',
                color: Colors.white,
                textColor: const Color.fromARGB(255, 14, 186, 238),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()), 
                        (route) => false, 
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
