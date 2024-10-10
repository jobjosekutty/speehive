
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:speehive/core/app_constants.dart';
import 'package:speehive/core/error_handler.dart';
import 'package:speehive/presentation/screens/dashboard.dart';
import 'package:speehive/presentation/widget/snack_bar.dart';

import '../../core/app_color.dart';
import '../provider/login_provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();



  final formKey = GlobalKey<FormState>();

  final usernameFocusNode = FocusNode();

  final passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "login",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<LoginProvider>(
        builder: (context, value, child) {
           
          if(value.loginSucess){

             WidgetsBinding.instance.addPostFrameCallback((time){
                   scaffoldMessengerKey.currentState?.showSnackBar(
              appSnackBar(
                "Login Success",
                Colors.green,
              ),
            );
            value.loginSucess = false;
               Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()),
                          );
    });
              
          }
        

          if(value.homeFailure is StatusCodeFailure){
             WidgetsBinding.instance.addPostFrameCallback((time){
                scaffoldMessengerKey.currentState?.showSnackBar(
              appSnackBar(
                "Invalid username or password!",
                Colors.red,
              ),
            );
            value.setFailure =null;

             });
            
            

          }

      
          
        return   Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: usernameFocusNode,
                        controller: usernameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter Username';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          floatingLabelStyle: GoogleFonts.poppins(
                            color: AppColors.primarycolor,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 8.0,
                          ),
                          label: const Text(
                            'username',
                          ),
                          hintText: 'username',
                          labelStyle: appTextStyle(),
                          hintStyle: appTextStyle(),
                          border: OutlineInputBorder(
                            borderRadius: textFieldBorderRadius,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: textFieldBorderRadius,
                            borderSide:  BorderSide(
                              width: 0.5,
                              color: AppColors.primarycolor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: textFieldBorderRadius,
                            borderSide: const BorderSide(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      setHeight(16),
                      TextFormField(
                        
                        focusNode: passwordFocusNode,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter Password';
                          }
        
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        obscureText:  Provider.of<LoginProvider>(context, listen: false).isObscure,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                                 Provider.of<LoginProvider>(context, listen: false).visibility();
                          }, icon: const Icon(Icons.visibility)),
                          floatingLabelStyle: GoogleFonts.poppins(
                            color: AppColors.primarycolor,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 8.0,
                          ),
                          label: const Text(
                            'password',
                          ),
                          hintText: 'password',
                          labelStyle: appTextStyle(),
                          hintStyle: appTextStyle(),
                          border: OutlineInputBorder(
                            borderRadius: textFieldBorderRadius,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: textFieldBorderRadius,
                            borderSide: BorderSide(
                              width: 0.5,
                              color: AppColors.primarycolor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: textFieldBorderRadius,
                            borderSide: const BorderSide(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      setHeight(16),
                        RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'By clicking the login button below,you acknowledge that you have read and agree to our ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    setHeight(16),
                    
                 
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                         
                                  
                    value.isLoading?const Center(child: CupertinoActivityIndicator(radius: 15,)):              CupertinoButton(
                                      onPressed: () {
                                         FocusScope.of(context).unfocus();
                                        if (formKey.currentState!.validate()) {
                                             Provider.of<LoginProvider>(context, listen: false).login(usernameController.text,passwordController.text);
                                          }
                                      },
                                      color: AppColors.primarycolor,
                                      child: Text(
                                        'login',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                           
                        ],
                      ),
                      setHeight(8),
                      Image.asset(
                        "assets/logo.png",
                        height: 175,
                        width: 175,
                      )
        
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
        },
        
      ),
    );
  }
}
