import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:core';

import '../pages/inscription_page.dart';

class InscriptionButton extends StatelessWidget {
  const InscriptionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InscriptionPage())
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
                color: Colors.greenAccent
            ),
            color: Colors.green,
          ),

          child: const Center(
            child: Text('INSCRIPTION', style: TextStyle(
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
