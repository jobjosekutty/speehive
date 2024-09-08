import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speehive/di/get_it.dart';
import 'package:speehive/presentation/provider/login_provider.dart';
import 'package:speehive/presentation/screens/splash_screen.dart';

import 'core/app_constants.dart';
import 'presentation/provider/item_provider.dart';
void main()async{
      await configdependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(
            create: (context) => getIt<ItemProvider>()),
               ChangeNotifierProvider(
            create: (context) => getIt<LoginProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
           scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen()
      ),
    );
  }
}


