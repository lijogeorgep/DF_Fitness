import 'package:df_fitness/screens/verifyOTP.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String verificationId = "";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Image.asset('assets/logo.png', height: 350),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.phone_iphone,
                      color: Colors.cyan,
                    ),
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Enter Your Phone Number...",
                    fillColor: Colors.white70),
                onChanged: (value) {},
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 100),
                shape: const CircleBorder(),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '+91${phoneNumberController.text}',
                  verificationCompleted:
                      (PhoneAuthCredential credential) async {
                    await auth.signInWithCredential(credential);
                  },
                  verificationFailed: (FirebaseAuthException e) {
                    if (e.code == 'invalid-phone-number') {
                      debugPrint('The provided phone number is not valid.');
                    }
                  },
                  codeSent: (String verificationId, int? resendToken) {
                    LoginScreen.verificationId = verificationId;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifyOtpScreen()));
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
              child: const Text(
                "Generate OTP",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                "Please enter the phone number followed by country code",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
