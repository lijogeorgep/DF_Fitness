import 'package:df_fitness/screens/bottomNavigationScreen.dart';
import 'package:df_fitness/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Image.asset('assets/logo.png', height: 350),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Pinput(
                length: 6,
                onCompleted: (pin) {
                  debugPrint('pincode:' + pin);
                },
                onChanged: (Value) {
                  smsCode = Value;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 50.0),
                  ),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 20))),
              onPressed: () async {
                try {
                  // Create a PhoneAuthCredential with the code
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: LoginScreen.verificationId,
                      smsCode: smsCode);

                  // Sign the user in (or link) with the credential
                  await auth.signInWithCredential(credential);
                  if (!mounted) return;

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavigationScreen()),
                      (route) => false);
                } catch (e) {
                  debugPrint('Error:$e');
                }
              },
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
