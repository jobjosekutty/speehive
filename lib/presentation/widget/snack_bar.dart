// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

SnackBar appSnackBar(String message, Color backgroundColor) => SnackBar(
  duration: Duration(seconds: 4),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      content: Text(
        message,
       
      ),
    );