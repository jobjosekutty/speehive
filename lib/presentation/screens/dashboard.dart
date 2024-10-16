// ignore_for_file: deprecated_member_use, use_build_context_synchronously, unnecessary_brace_in_string_interps, avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speehive/core/app_color.dart';
import 'package:speehive/presentation/screens/login.dart';


import '../../core/app_constants.dart';
import '../../di/get_it.dart';
import '../provider/item_provider.dart';
import '../widget/snack_bar.dart';
import 'home.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

   Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Do you really want to exit the app?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Yes"),
          ),
        ],
      ),
    )) ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: AppColors.darkScaffold,
        appBar: AppBar(backgroundColor: AppColors.appbar,title: Text("DashBoard",style:GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.white
                                            
                                          ),),centerTitle: true,actions: [
                                              PopupMenuButton<String>(
                                                icon: const Icon(Icons.logout,color: Colors.white,),
            onSelected: (value) async{
           
              if (value == 'Logout') {
                      WidgetsBinding.instance.addPostFrameCallback((time)async{
                                   final SharedPreferences preferences = await SharedPreferences.getInstance();
           preferences.setString("token","").then((value) {
            log("value is ${value}");
                  Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  LoginScreen()),
                          );
                             scaffoldMessengerKey.currentState?.showSnackBar(
              appSnackBar(
                "Logout Success",
                Colors.green,
              ),
            );

             
           },);

                print("Logout selected");

                      });
       
              }
            
            },
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
                                          ],),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
            
              GestureDetector(
                onTap: () {
                   Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) => getIt<ItemProvider>()..getItem(),
                                  child: Home(),
                                )),
                      );
                },
                child: Container(height: 200,width: 200 ,decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.white),borderRadius: BorderRadius.circular(5),  gradient: LinearGradient(
                            colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.1)],
                            stops: const [0.0, 1.0],
                          ),),child: Center(
                child: Column(
                  children: [
                    Image.asset("assets/project.jpg"),
                
                  ],
                ),
                                ),),
              ),
                              Text("Project Details",style:GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                        color: Colors.white
                                                        
                                                      ),)
            ],
          ),
        ),
      ),
    );
  }
}