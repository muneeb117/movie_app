import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/view/screens/more_screen/profile_screen.dart';
import 'package:movie_app/view/screens/movie_list/movie_list.dart';
import 'package:movie_app/view/screens/watch/watch.dart';

Widget buildPage(int index) {
  List<Widget> _widgets = [

    MovieListScreen(),
    WatchScreen(),
    WatchScreen(),

    ProfileScreen(),
    // ProfilePage()
  ];
  return _widgets[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
      label: "Dashboard",
      icon: SizedBox(
        height: 22.h,
        width: 22.w,
        child: SvgPicture.asset("assets/icons/dashboard.svg"),
      ),
      activeIcon: SizedBox(
        height: 22.h,
        width: 22.w,
        child: SvgPicture.asset(
          "assets/icons/dashboard_white.svg",
        ),
      )),
  BottomNavigationBarItem(
      label: "Watch",
      icon: SizedBox(
        height: 22.h,
        width: 22.w,
        child: SvgPicture.asset("assets/icons/watch.svg"),
      ),
      activeIcon: SizedBox(
        height: 22.h,
        width: 22.w,
        child: SvgPicture.asset(
          "assets/icons/watch_white.svg",
        ),
      )),

  BottomNavigationBarItem(
      label: "Media Library",
      icon: SizedBox(
        height: 22.h,
        width: 22.w,
        child: SvgPicture.asset("assets/icons/media_library.svg"),
      ),
      activeIcon: SizedBox(
        height: 22.h,
        width: 22.w,
        child: SvgPicture.asset(
          "assets/icons/media_library_white.svg",
        ),
      )),
  BottomNavigationBarItem(
      label: "More",
      icon: SizedBox(
        height: 19.h,
        width: 19.w,
        child: Icon(Icons.tune_outlined,color: Color(0xff827D88),),
      ),
      activeIcon: SizedBox(
        height: 19.h,
        width: 19.w,
        child: Icon(Icons.tune_outlined,color: Colors.white,),
      )),
];
