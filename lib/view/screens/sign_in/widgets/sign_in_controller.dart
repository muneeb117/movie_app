import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/routes/name.dart';

import '../../../../global.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/flutter_toast.dart';
import '../bloc/signin_blocs.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "email") {
        final state = context.read<SignInBlocs>().state;
        String emailAddress = state.email;
        String password = state.password;
        if (emailAddress.isEmpty) {
          toastInfo(msg: "Your need to fill email address");return;
        }
        if (password.isEmpty) {
          toastInfo(msg: "Your need to fill password address");return;
        }
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password);
          if (credential.user == null) {
            toastInfo(msg: "You don't exist");return;
          }

          var user = credential.user;
          if (user != null) {
            String? token = await user.getIdToken();
            Global.storageServices.setString(AppConstants.STORAGE_USER_TOKEN_KEY, token!);
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.application, (route) => false);
          } else {
            print("user not exist");
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == "user-not-found") {
            toastInfo(msg: "User Not Found for that email");
          } else if (e.code == "wrong-password") {
            toastInfo(msg: "wrong password provided for that user");
          } else if (e.code == "invalid-email") {
            toastInfo(msg: "wrong password provided for that user");
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
