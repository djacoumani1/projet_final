import 'package:flutter/material.dart';
import 'package:projet_final/models/twitt.dart';
import '../bd/bd.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/list_twitt_perso.dart';

class ProfilTwittPage extends StatelessWidget{
  const ProfilTwittPage({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff0b1d31),
        body: Center(
          child: SizedBox(
            height: 600,
            width: 400,
            child: Stack(
            children: [
              TwittPersoPage()
            ],
        ),
          ),
        ),
        ),

    );
  }
}