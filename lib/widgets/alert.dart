import 'package:flutter/material.dart';
import 'package:projet_final/main.dart';

showAlertDialog(BuildContext context) {

  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),//
      );
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("INSCRIPTION COMPLETEE"),
    content: Text("Vous pouvez maintenant vous connecter avec vos identifiants :)"),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}