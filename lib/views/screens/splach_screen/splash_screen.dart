import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo_night/utils/colors.dart';
import 'package:memo_night/views/screens/auth/login.dart';

import '../crud/index.dart';

class splachScreen extends StatefulWidget {
  @override
  _splachScreenState createState() => _splachScreenState();
}

class _splachScreenState extends State<splachScreen> {
  bool _a = false;

  @override
  void initState() {
    super.initState();
    var user = FirebaseAuth.instance.currentUser;
    Timer(const Duration(milliseconds: 700), () {
      setState(() {
        _a = !_a;
      });
    });
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacement(
          SlideTransitionAnimation(user == null ? Login() : const Index()));
    });
  }


  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:AppColors.black,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 2500),
            curve: Curves.fastLinearToSlowEaseIn,
            width: _a ? _width : 0,
            height: _height,
            color: AppColors.mainColor,
          ),
            Center(
            child: Text(
              'Memo Night',
              style:GoogleFonts.greatVibes(color: AppColors.blue,fontSize: 55,fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideTransitionAnimation extends PageRouteBuilder {
  final Widget page;

  SlideTransitionAnimation(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: const Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
              );
              return SlideTransition(
                position: Tween(
                        begin: const Offset(1.0, 0.0),
                        end: const Offset(0.0, 0.0))
                    .animate(animation),
                textDirection: TextDirection.rtl,
                child: page,
              );
            });
}
