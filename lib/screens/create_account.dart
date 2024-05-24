import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invest_app/Firebase/firebase_service.dart';
import 'package:invest_app/screens/home_page.dart';
import 'package:invest_app/widgets/custom_text_button.dart';
import 'package:invest_app/widgets/text__widget.dart';
import 'package:invest_app/widgets/custom_button.dart'; // Import the custom button

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final FirebaseAuthService auth = FirebaseAuthService();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  Future<void> registerUser() async {
    String firstname = firstnameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    // Check if the password is strong
    if (!isStrongPassword(password)) {
      showSnackBar('Password must be at least 8 characters long and contain a combination of uppercase letters, lowercase letters, and special characters.');
      return;
    }

    try {
      User? user = await auth.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        // Add user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'firstname': firstname,
          'email': email,
          'password': password,
        });
        // Show a success message
        showSnackBar('Account created successfully!');
        await Future.delayed(const Duration(seconds: 1));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        showSnackBar('Error creating account!');
        firstnameController.clear();
        emailController.clear();
        passwordController.clear();
      }
    } catch (error) {
      showSnackBar('Try creating account again!: $error');
      firstnameController.clear();
      emailController.clear();
      passwordController.clear();
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  bool isStrongPassword(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 80, left: 80, top: 100),
              child: CustomText(
                text: "Create an account",
                size: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 80, left: 80, top: 10),
              child: CustomText(
                text: "Invest and double your income now",
                size: 12,
                color: const Color.fromARGB(255, 145, 138, 138),
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: firstnameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                labelText: 'Full name',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                isDense: true,
                              ),
                              validator: (value) => value!.isEmpty ? 'Please enter username' : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email address',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                isDense: true,
                              ),
                              validator: (value) => value!.isEmpty ? 'Please enter email' : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: !isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Enter Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                isDense: true,
                              ),
                              validator: (value) => value!.isEmpty ? 'Please enter password' : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: CustomButton(
                        text: 'Create account',
                        color: const Color.fromARGB(255, 14, 186, 238),
                        textColor: Colors.white,
                        onPressed: registerUser,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: CustomTextButton(
                        text: 'Already have an account?',
                        color: Colors.white,
                        textColor: const Color.fromARGB(255, 14, 186, 238),
                        onPressed: () {
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const LoginPage()), // Replace LoginPage with your login page widget
                          //       (route) => false, // Remove all routes until this point
                          // );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> main() async {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignPage(),
  ));
}
