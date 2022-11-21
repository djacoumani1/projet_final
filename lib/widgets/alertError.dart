import 'dart:async';
import 'package:flutter/material.dart';


void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
      ));
}