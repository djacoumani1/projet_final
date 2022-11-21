import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:core';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class Logo_nom extends StatelessWidget {
  const Logo_nom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Stack(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(70, 60, 220, 0),
            child: Image(
              width: 30,
              height: 30,
              image: Svg('assets/chat.svg'),
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(110,60,0,0),
            child: Text("Djacoumani", style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w800
            ),
            ),
          )
        ],
      ),
    );
  }
}
