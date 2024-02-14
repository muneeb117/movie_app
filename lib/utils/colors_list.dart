import 'package:flutter/material.dart';

Color textColor = Colors.grey.shade800;
Color selectColor = const Color(0xFFDAA520);
Color vipColor = const Color(0xFF673AB7);
Color regularColor = const Color(0xFF04E6D8);
Color fillColor = Colors.blue.shade300;
Color delColor = const Color(0xffB81736);


List<Color> genreColors =const  [
  Color(0xFFE57373),
  Color(0xFFF06292),
  Color(0xFFBA68C8),
  Color(0xFF9575CD),
  Color(0xFF7986CB),
  Color(0xFF64B5F6),
  Color(0xFF4FC3F7),
  Color(0xFF4DD0E1),
  Color(0xFF4DB6AC),
  Color(0xFF81C784),
  Color(0xFFAED581),
  Color(0xFFFFD54F),
  Color(0xFFFFB74D),
  Color(0xFFFF8A65),
  Color(0xFFFF7043),
  Color(0xFF8D6E63),
  Color(0xFFA1887F),
  Color(0xFFE0E0E0),
  Color(0xFF90A4AE),
];

class AppColors {
  /// pink color for buttons
  static const Color primaryBackground = Color.fromARGB(255, 255, 101, 132);

  /// grey background
  static const Color primarySecondaryBackground = Color.fromARGB(
      255, 245, 245, 245);


  static const Color primaryText = Color.fromARGB(255, 245, 245, 245);

  static const Color dateColor = Color.fromARGB(255, 166, 166, 166);


  /// Stroke Colors
  static const Color strokeColor = Color.fromARGB(255, 236, 236, 236);

  //build dot non active color
  static const Color nonActive = Color.fromARGB(255, 53, 56, 63);

  /// build dot active color
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 255, 128, 77), // Starting color
      Color.fromARGB(255, 255, 131, 149), // Ending color
    ],
  );




  /// main text color black
  //static const Color primaryText = Color.fromARGB(255, 0, 0, 0);


  /// video backgroun color
  static const Color primary_bg = Color.fromARGB(255, 46, 39, 57);


  /// main widget text color white
  static const Color primaryElementText = Color.fromARGB(255, 255, 255, 255);
  // main widget text color grey
  static const Color primarySecondaryElementText = Color.fromARGB(
      255, 130, 125, 136);
  // main widget third color grey
  static const Color primaryThreeElementText = Color.fromARGB(
      255, 155, 154, 154);

  static const Color primaryFourElementText = Color.fromARGB(255, 204, 204, 204);
  //state color
  static const Color primaryElementStatus = Color.fromARGB(255, 88, 174, 127);

  static const Color primaryElementBg = Color.fromARGB(255, 238, 121, 99);


}
