import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:expenses_management/components/user_snackbar.dart';
import 'package:expenses_management/models/user.dart';
import 'package:expenses_management/services/f_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on Firebase user
  UserClass? _userFromFirebaseUser(User? user) {
    return user != null ? UserClass(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<UserClass?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign in with email and password
  Future signIn(String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await DatabaseService(uid: user!.uid).updateFcmToken(fcmToken);
      }
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      AppSnackBar.showSnackBar(context, 'Error: ${e.message}');
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future register(String email, String password, String fullName,
      String phoneNumber, BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid)
          .createUserData(fullName, phoneNumber, email);
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await DatabaseService(uid: user.uid).updateFcmToken(fcmToken);
      }
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      AppSnackBar.showSnackBar(context, 'Error: ${e.message}');
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Reset password
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("Failed to send password reset email: ${e.message}");
    }
  }
}
