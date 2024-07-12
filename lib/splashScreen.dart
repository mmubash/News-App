import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/home_screen.dart';
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds:3 ), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
  }
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height*1;
    return Scaffold(
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/splash_pic.jpg",
              fit: BoxFit.cover,
            height: height*.6,

            ),
            SizedBox(height: height*0.04,),
            Text('Top Headlines',style: GoogleFonts.anton(letterSpacing:.6,color:Colors.grey.shade700),),
            SizedBox(height: height*0.04,),
            SpinKitChasingDots(
              color: Colors.grey,
              size: 40,
            )
          ],
        ),
      )
    );
  }
}
