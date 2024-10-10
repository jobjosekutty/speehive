import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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


     final SharedPreferences preferences = await SharedPreferences.getInstance();
       var auth = preferences.getString("token");  
      final response = await http.get(Uri.parse("https://focali-uat.azurewebsites.net/api/app/projecttask/withOutDetails?filter=projectDetailId%20eq%20%22${id}%22&onlyActive=true&maxResultCount=500"),headers: {'Authorization': 'Bearer ${auth}',});
      log(response.body);
      if(response.statusCode ==200){
            data = lookUpModelFromJson(response.body);
    print("======look${data?.items?.length}");
     lookuploading = false;
     setState(() {
       
     });

      }
   
  }
  
  
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
                             key: Key(selectedTile.toString()),
                        itemCount: value.details?.items.length,
                        itemBuilder: (context, index) {
                          final item = value.details?.items[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () {
     log("test");
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => DetailsScreen(
                                //       projectno: value.details?.items[index].projectNo,
                                //       portname: value.details?.items[index].portName,
                                //       type: value.details?.items[index].typeOfCallName,
                                //       vesselname: value.details?.items[index].vesselName,
                                //       customername: value.details?.items[index].customerName,
                                //     ),
                                //   ),
                                // );
                              },
                              child: Container(
                                 padding:  const EdgeInsets.all(10),
                                  margin:  const EdgeInsets.only(bottom: 6),
                                  decoration: BoxDecoration(
                                                    
                                 
                                    borderRadius: BorderRadius.circular(10),
                                   border: Border.all(width: 2,color: Colors.white)
                                  ),
                                child: ExpansionTile(  
                                    key: Key(index.toString()), 
                                 initiallyExpanded: index == selectedTile,
                               //   controller: _controller,
                                  onExpansionChanged: (newState) {
                                    print(newState);
                                    if(newState){
                                               
                                       setState(() {
                selectedTile = newState ? index : -1;
              });
                                  fetch(item!.id.toString());                     
                                     print( item?.id.toString());

                                    } 
                                 
                                  },
                                
                                  title:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                           Text(
                                            "ProjectNo:",
                                          style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white
                                          
                                        ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                            child: Text(
                                              item?.projectNo ?? "NA",
                                             style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white
                                          
                                        ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                           Text(
                                            "ProtName:",
                                           style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white
                                          
                                        ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                            child: Text(
                                              item?.portName ?? "NA",
                                               style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white
                                          
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
                                           style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white
                                          
                                        ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                            child: Text(
                                              item?.typeOfCallName ?? "NA",
                                              style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white
                                          
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
                                            style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white
                                          
                                        ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                            child: Text(
                                              item?.vesselName ?? "NA",
                                              style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white
                                          
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
                                             style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white
                                          
                                        ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                            child: Text(
                                              item?.customerName ?? "NA",
                                             style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white
                                          
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
                                          style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white
                                          
                                        ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                            child: Text(
                                              item?.projectPortCallEta.toString() ?? "NA",
                                              style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white
                                          
                                        ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                   children: <Widget>[
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
                                                           ListTile(
                                                        title: Text(data?.items?[index].taskItemName.toString()??'NA',style: const TextStyle(color: Colors.white),),
                                                      subtitle: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Text("UserProfileName:",style: TextStyle(color: Colors.white),),
                                                              Text(data?.items?[index].userProfileName.toString()??"NA",style: const TextStyle(color: Colors.white),),
                                                            ],
                                                          ),
                                                            Row(
                                                              children: [
                                                                const Text("ProjectDetailsNo:",style: TextStyle(color: Colors.white),),
                                                                Text(data?.items?[index].projectDetailProjectNo .toString()??"NA",style: const TextStyle(color: Colors.white),),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text("ID:",style: TextStyle(color: Colors.white),),
                                                                Text(data?.items?[index].id .toString()??"NA",style: const TextStyle(color: Colors.white),),
                                                              ],
                                                            ),
                                                        ],
                                                      ),
                                                      );
                                                        
                                                      },),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
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
