import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:invest_app/Firebase/firebase_service.dart';
import 'package:invest_app/screens/home_page.dart';
import 'package:invest_app/widgets/custom_text_button.dart';
import 'package:invest_app/widgets/text__widget.dart';
import 'package:invest_app/widgets/custom_button.dart'; // Import the custom button

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService auth = FirebaseAuthService();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  bool isPasswordVisible = false;
  String? email;
  String? password;
  Future<void> validateUser() async {
    String email = emailController.text;
    String password = passwordController.text;
    try {
      User? user = await auth.signInWithEmailAndPassword(email, password);
      if (user != null) {
        // Retrieve user data from Firestore
        DocumentSnapshot<Map<String, dynamic>> userData =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userData.exists) {
          
          // Navigate the user according to their role
            await secureStorage.write(key: 'email', value: email);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
           
        } else {
          showSnackBar('User data not found');
        }
      } else {
        showSnackBar('Invalid details try again!');
        emailController.clear();
        passwordController.clear();
      }
    } catch (error) {
      showSnackBar('Error occurred: $error');
      emailController.clear();
      passwordController.clear();
    }
  }

  // Method to show a SnackBar
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Center(
          // Center-align the text
          child: Text(
            message,
            style: const TextStyle(color: Colors.orange, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
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
                text: "Login Now",
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
                        text: 'Login',
                        color: const Color.fromARGB(255, 14, 186, 238),
                        textColor: Colors.white,
                        onPressed: validateUser,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: CustomTextButton(
                        text: "Don't have an account?",
                        color: Colors.white,
                        textColor: const Color.fromARGB(255, 14, 186, 238),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const SignPage()), // Replace LoginPage with your login page widget
                                (route) => false, // Remove all routes until this point
                          );
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
    home: LoginPage(),
  ));
}
