
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speehive/core/app_color.dart';


class DetailsScreen extends StatefulWidget {
   const DetailsScreen({super.key, this.projectno, this.portname, this.type, this.vesselname, this.customername,});

  final String? projectno;
  final String? portname;
  final String? type;
  final String? vesselname;
  final String? customername;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.darkScaffold,
      appBar: AppBar(
        
          iconTheme: const IconThemeData(
    color: Colors.white,
  ),
        title:  Text("Details Screen", style:GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white
                                          
                                        ),),centerTitle: true,backgroundColor:AppColors.appbar,),
      body: Container(
        height: 140,
                                padding:  const EdgeInsets.all(10),
                                margin:  const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                    
                               
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 2,color: Colors.white)
                                ),
                                child: Column(
                                //  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                           widget.projectno ?? "NA",
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
                                           widget.portname ?? "NA",
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
                                          widget.type ?? "NA",
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
                                            widget.vesselname ?? "NA",
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
                                            widget.customername ?? "NA",
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
    );
  }
}