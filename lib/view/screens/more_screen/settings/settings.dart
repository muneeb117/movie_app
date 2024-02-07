import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global.dart';
import '../../../../routes/name.dart';
import '../../../../utils/constants.dart';
import '../../application/bloc/app_blocs.dart';
import '../../application/bloc/app_events.dart';
import 'bloc/setting_bloc.dart';
import 'bloc/setting_state.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void removeUserData() {
    context.read<AppBlocs>().add(TriggeredEvents(0));
    Global.storageServices.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<SettingBlocs, SettingStates>(
        builder: (BuildContext context, state) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Conform Logout",),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  removeUserData();
                                },
                                child: Text("Conform"))
                          ],
                        );
                      });
                },
                child: Container(
                  height: 100.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage("assets/icons/Logout.png"),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
