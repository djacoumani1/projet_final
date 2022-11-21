import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:core';import '../pages/connexion_page.dart';


import '../pages/inscription_page.dart';

class ConnexionButton extends StatelessWidget {
  const ConnexionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConnexionPage())
          );
        },
        borderRadius: BorderRadius.circular(30),
        highlightColor: Color(0xff58d1ff),
        splashColor: Color(0xff58d1ff),
        child: Container(
          height: 50.0,
          width: 300,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                width: 2,
                color: Colors.blueAccent
            ),
            color: Colors.blue,
          ),

          child: const Center(
            child: Text('CONNEXION', style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
        ),
      ),
    );
  }
}
