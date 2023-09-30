import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const Color color=Color(0xFFA7171A);

String ?uId;


const Color primaryColor = Color(0xFF2967FF);
const Color grayColor = Color(0xFF8D8D8E);

const double defaultPadding = 16.0;

ThemeData lightTheme=ThemeData(
  canvasColor: color,
    focusColor: Colors.grey,
    hintColor: color,
  shadowColor: Color(0xFFEEEEEE),
  iconTheme:IconThemeData(
    color: Colors.black
  ),
    cardColor:Colors.white,
    textTheme: TextTheme(
        bodyText1: GoogleFonts.dmSans(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Colors.black
        ),
      bodyText2: GoogleFonts.dmSans(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black
      ),
        subtitle1:GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
            color: Colors.black,
        ),
        headline6: TextStyle(
            fontSize: 13,
            color: Colors.blue
        ),
      caption: GoogleFonts.poppins(
          fontSize: 12,color: Colors.black,

      ),

    ),
    primaryColor: color,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.montserrat(color: Colors.black,
            fontSize: 23,fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black,size: 28)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        selectedItemColor: Colors.blue,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black45
    )
);





ThemeData darkTheme=ThemeData(
    canvasColor: Colors.white,
    hintColor: Colors.white,
    focusColor: Colors.white,
    shadowColor: Colors.black12,
    iconTheme:IconThemeData(
        color:Colors.white
    ),
  cardColor:Color(0xFF333739) ,
    textTheme: TextTheme(
      bodyText1: GoogleFonts.dmSans(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: Colors.white
      ),
      bodyText2: GoogleFonts.dmSans(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white
      ),
      subtitle1:GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      headline6: TextStyle(
          fontSize: 13,
          color: Colors.blue
      ),
      caption: GoogleFonts.poppins(
        fontSize: 12,
       color: Colors.white,
      ),

    ),
    primaryColor: Colors.blue,
    scaffoldBackgroundColor:Color(0xFF333739),
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:Color(0xFF333739),
            statusBarIconBrightness: Brightness.light
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.montserrat(color: Colors.white,
            fontSize: 23,fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white,size: 28)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        selectedItemColor: Colors.blue,
        backgroundColor: Color(0xFF333739),
        unselectedItemColor: Colors.white
    )
);