import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


ThemeData myThemeData = ThemeData(
  backgroundColor: HexColor("#F6F6F6"),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(color: HexColor("#38C1CE"),fontSize: 22, fontWeight: FontWeight.w700),
    iconTheme: IconThemeData(
      color: HexColor("#38C1CE")
    ),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
  ),
  iconTheme: IconThemeData(
    color: HexColor("#38C1CE")
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: HexColor("#38C1CE"),
    unselectedItemColor: HexColor("#38C1CE"),
    showUnselectedLabels: true,
  ),
  buttonTheme: ButtonThemeData(

  )
);

