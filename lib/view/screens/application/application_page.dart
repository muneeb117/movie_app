import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/view/screens/application/widgets/application_widgets.dart';
import '../../../utils/colors_list.dart';
import 'bloc/app_blocs.dart';
import 'bloc/app_events.dart';
import 'bloc/app_states.dart';


class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBlocs,AppStates>(builder: (context,state){
      return Scaffold(
        body: buildPage(state.index),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.h),
                topRight: Radius.circular(20.h),
              ),
              boxShadow: [
                BoxShadow(
                    color:AppColors.primary_bg.withOpacity(0.1),

                    spreadRadius: 1,
                    blurRadius: 1
                ),
              ],
          ),
          child:  BottomNavigationBar(
            backgroundColor: AppColors.primary_bg,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            selectedItemColor: Colors.white,
            unselectedItemColor:AppColors.primarySecondaryElementText,


            currentIndex: state.index,
            onTap: (value) {
              context.read<AppBlocs>().add(TriggeredEvents(value));
            },
            elevation: 0,
            items: bottomTabs
          ),
        ),

      );
    });

  }
}
