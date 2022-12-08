import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:core';

import '../main.dart';

class DeconnexionButton extends StatelessWidget {
  const DeconnexionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp())
          );
        },
        borderRadius: BorderRadius.circular(30),
        highlightColor: Color(0xff58d1ff),
        splashColor: Color(0xff58d1ff),
        child: Container(
          height: 50.0,
          width: 150,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                width: 2,
            ),
            color: Colors.red,
          ),

          child: const Center(
            child: Text('DECONNEXION', style: TextStyle(
              fontSize: 14,
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
