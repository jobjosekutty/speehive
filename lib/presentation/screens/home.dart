// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speehive/core/app_color.dart';
import 'package:speehive/presentation/provider/item_provider.dart';
import '../../core/app_constants.dart';
import '../../core/error_handler.dart';
import '../../data/models/lookupmodel.dart';
import '../widget/snack_bar.dart';
import 'package:lottie/lottie.dart';
import "package:http/http.dart" as http;

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  bool lookuploading = false;
  LookUpModel?  data;
    int selectedTile = -1;
   //final ExpansionTileController expantionTileController = ExpansionTileController();

   fetch(String id) async {
     lookuploading = true;
     setState(() {
       
     });
     //=======

     //=======


     final SharedPreferences preferences = await SharedPreferences.getInstance();
       var auth = preferences.getString("token");  
      final response = await http.get(Uri.parse("https://focali-uat.azurewebsites.net/api/app/projecttask/withOutDetails?filter=projectDetailId%20eq%20%22$id%22&onlyActive=true&maxResultCount=500"),headers: {'Authorization': 'Bearer $auth',});
      log(response.body);
      if(response.statusCode ==200){
            data = lookUpModelFromJson(response.body);
    print("======look${data?.items?.length}");
     lookuploading = false;
     setState(() {
       
     });

      }
   
  }

     int? expandedIndex;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkScaffold,
      appBar: AppBar(
          iconTheme: const IconThemeData(
        color: Colors.white,
      ),
        title:  Text("SpeeHive",style:GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white
                                        
                                      ),),
        centerTitle: true,
        backgroundColor: AppColors.appbar,
      ),
      body: Consumer<ItemProvider>(
        builder: (context, value, child) {
          if (value.homeFailure != null && value.homeFailure is NetworkFailure) {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () async {
                Provider.of<ItemProvider>(context, listen: false).getItem();
                refreshController.refreshCompleted();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/network.json',
                    width: 500,
                    height: 500,
                    fit: BoxFit.fill,
                  ),
                   Text(
                    "No Internet",
                     style:GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white
                                        
                                      ),
                  ),
                ],
              ),
            );
          }
    
          if (value.homeFailure is ServerFailure) {
            scaffoldMessengerKey.currentState?.showSnackBar(
              appSnackBar(
                "Server Failure",
                Colors.red,
              ),
            );
          }
    
          if (value.homeFailure is ServerErrorFailure) {
            WidgetsBinding.instance.addPostFrameCallback((time) {
              scaffoldMessengerKey.currentState?.showSnackBar(
                appSnackBar(
                  "Server Failure ===>500",
                  Colors.red,
                ),
              );
            });
          }
    
          if (value.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
    
       if (value.details != null && value.details!.items.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: value.details?.items.length,
                  itemBuilder: (context, index) {
                    final item = value.details?.items[index];
                    final isExpanded = expandedIndex == index;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        onTap: () async {
                          if (isExpanded) {
                            setState(() {
                              expandedIndex = null;
                            });
                          } else {
                            setState(() {
                              expandedIndex = index;
                            });
                          await fetch(item!.id);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Colors.white),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "ProjectNo:",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                            item?.projectNo ?? "NA",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "PortName:",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                            item?.portName ?? "NA",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "TypeOfCallName:",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                            item?.typeOfCallName ?? "NA",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Vessel Name:",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                            item?.vesselName ?? "NA",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "CustomerName:",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                            item?.customerName ?? "NA",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "ProjectportCalleta:",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                            item?.projectPortCallEta.toString() ?? "NA",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isExpanded) ...[
                                      const SizedBox(height: 20),
                                         SizedBox(
                                                    height: 200,
                                                    child:  SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 200,
                                                            child:  lookuploading
                                            ? const Center(child: CircularProgressIndicator()) :
                                            data?.totalCount == 0 ? const Center(child: Text("No Data Found",style: TextStyle(color: Colors.white),))
                                            
                                                
                                            
                                                          :     ListView.builder(
                                                              itemCount: data?.items?.length
                                                              ,
                                                              itemBuilder: (context, index) {
                                                            return 
                                                                 Container(
                                                                  margin: const EdgeInsets.only(top: 5),
                                                               
                                                                  decoration: BoxDecoration(   color: Colors.grey[600],borderRadius: BorderRadius.circular(6)),
                                                                   child: ListTile(
                                                                                                                           title: Text(data?.items?[index].taskItemName.toString()??'NA',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                                                                                                         subtitle: Column(
                                                                                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                           children: [
                                                                                                                             Row(
                                                                    children: [
                                                                      Icon(Icons.person,color: Colors.white,),
                                                                      setWidth(8),
                                                                      const Text("UserProfileName:",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                                                      Text(data?.items?[index].userProfileName.toString()??"NA",style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                                                                             ),
                                                                    Row(
                                                                      children: [
                                                                            const Icon(Icons.task,color: Colors.white,),
                                                                            setWidth(8),
                                                                        const Text("ProjectDetailsNo:",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                                                        Text(data?.items?[index].projectDetailProjectNo .toString()??"NA",style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                            const Icon(Icons.card_membership,color: Colors.white,),
                                                                            setWidth(8),
                                                                        const Text("ID:",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                                                        Expanded(child: Text(data?.items?[index].id .toString()??"NA",style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),
                                                                      ],
                                                                    ),
                                                                                                                           ],
                                                                                                                         ),
                                                                                                                         ),
                                                                 );
                                                              
                                                            },),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                    ],
                                  ],
                                ),
                              ),
                      isExpanded?Container():        IconButton(onPressed: ()async{
                                   if (isExpanded) {
                            setState(() {
                              expandedIndex = null;
                            });
                          } else {
                            setState(() {
                              expandedIndex = index;
                            });
                          await fetch(item!.id);
                          }
                              }, icon: Icon(Icons.arrow_downward))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    
          return Center(
            child: CupertinoButton(
              color: Colors.green,
              child: const Text("Retry",style:TextStyle(color: Colors.white) ,),
              onPressed: () {
                Provider.of<ItemProvider>(context, listen: false).getItem();
              },
            ),
          );
        },
      ),
    );
  }
}
