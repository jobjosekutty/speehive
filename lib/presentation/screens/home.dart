import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:speehive/core/app_color.dart';
import 'package:speehive/presentation/provider/item_provider.dart';
import '../../core/app_constants.dart';
import '../../core/error_handler.dart';
import '../widget/snack_bar.dart';
import 'details_screen.dart';
import 'package:lottie/lottie.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

 
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
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      projectno: value.details?.items[index].projectNo,
                                      portname: value.details?.items[index].portName,
                                      type: value.details?.items[index].typeOfCallName,
                                      vesselname: value.details?.items[index].vesselName,
                                      customername: value.details?.items[index].customerName,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding:  const EdgeInsets.all(10),
                                margin:  const EdgeInsets.only(bottom: 6),
                                decoration: BoxDecoration(
                    
                               
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 2,color: Colors.white)
                                ),
                                child: Column(
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
