import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/flutter_toast.dart';
import '../bloc/register_bloc.dart';

class RegisterController {
  final BuildContext context;
  RegisterController({required this.context});

  Future<void> handleSignUp() async {
    final state = context.read<RegisterBloc>().state;
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;

    if (userName.isEmpty || email.isEmpty || password.isEmpty || rePassword.isEmpty) {
      toastInfo(msg: "Please fill in all fields");
      return;
    }
    if (rePassword != password) {
      toastInfo(msg: "Passwords do not match");
      return;
    }

    try {
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = credential.user;
      if (user != null) {
        // Add user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'userName': userName,
          'email': email,
        });

        toastInfo(msg: "Registration successful!");
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastInfo(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        toastInfo(msg: "An account already exists for that email.");
      } else {
        toastInfo(msg: "An error occurred. Please try again.");
      }
    } catch (e) {
      toastInfo(msg: "An error occurred. Please try again.");
    }
  }
}
