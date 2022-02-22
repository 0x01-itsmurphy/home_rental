// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _account;
  GoogleSignInAccount get account => _account!;

  Future googleLognIn() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      _account = googleUser;

      final googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
    
    notifyListeners();
  }

  Future googleSignOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    // notifyListeners();
  }
}
