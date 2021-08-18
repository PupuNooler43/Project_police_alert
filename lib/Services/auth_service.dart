
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_policealert/states/verify.dart';

class PhoneAuth {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(BuildContext context, number) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
      print('Error ${e.code}');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int? resendToken) async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Verify()));
    };

    try{
      auth.verifyPhoneNumber(phoneNumber: number, 
      verificationCompleted: verificationCompleted, 
      verificationFailed: verificationFailed, 
      codeSent: codeSent,
      timeout: const Duration(seconds: 60), 
      codeAutoRetrievalTimeout: (String verificationId){
        print(verificationId);
      });
    }catch(e){
      print('Error ${e.toString()}');
    }
  }
}
