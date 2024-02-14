import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../routes/name.dart';
import '../../../utils/colors_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 17.5, bottom: 20, left: 20, right: 20),
          child: Container(
            height: 12.h,
            width: 12.w,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/icons/menu.png")),
            ),
          ),
        ),
        title: const Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Profile",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
                size: 20,
              ))
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/Image.jpg"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey.withOpacity(0.5)),
                          color: Colors.white,
                          image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/icons/photo.png")),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Muneeb"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildReusableContainer(image: 'a_video', text: 'Watchlist'),
                buildReusableContainer(image: 'file-text', text: 'Bookings'),
                buildReusableContainer(image: 'star(2)', text: 'Favorites'),
              ],
            ),
            const SizedBox(height: 45),
            Column(
                children: List.generate(imagesInfo.length, (index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoutes.settings);
                    },
                    child: reusableProfileMenuItems(
                        imagePath: imagesInfo.keys.elementAt(index),
                        text: imagesInfo.values.elementAt(index),
                        context: context),
                  );
                })),
          ],
        ),
      ),
    );
  }
}

Widget buildReusableContainer({required String image, required String text}) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    height: 50.h,
    width: 100.w,
    decoration: BoxDecoration(
        color: AppColors.primary_bg,
        borderRadius: BorderRadius.circular(20)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 28,
            width: 29,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/icons/$image.png")),
            )),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        )
      ],
    ),
  );
}

Widget reusableProfileMenuItems(
    {required String imagePath, required String text, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Row(
      children: [
        Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primary_bg,
          ),
          child: Padding(
              padding:const  EdgeInsets.all(12),
              child: Image.asset("assets/icons/$imagePath.png")),
        ),
        const SizedBox(width: 25),
        Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.primarySecondaryElementText),
        ),
      ],
    ),
  );
}

var imagesInfo = <String, String>{
  "settings": "Settings",
  "credit-card": "Ticket Wallet",
  "heart": "Liked Movies",
  "cube": "Notifications",
  "award": "Rewards",
};
