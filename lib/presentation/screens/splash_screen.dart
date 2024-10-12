
// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speehive/presentation/screens/dashboard.dart';
import 'package:speehive/presentation/screens/login.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    fetchData();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();


    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

  }


     fetchData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    Future.delayed(const Duration(milliseconds: 3000), () {
      var auth = preferences.getString("token");
      print("===>$auth");
      if (auth != null && auth.toLowerCase().isNotEmpty) {
               Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()),
                          );
      } else {
       Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: _offsetAnimation,
            child: Center(
              child: Image.asset('assets/logo.png'),
            ),
          ),
          FadeTransition(
            opacity: _opacityAnimation,
            child: const Center(
              child: Text(
                'SpeeHive',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///////
///
