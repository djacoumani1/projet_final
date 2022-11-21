import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:projet_final/widgets/logo_nom.dart';
import '../bd/bd.dart';
import '../widgets/alertError.dart';
import 'profilpage.dart';

class PageAccueil extends StatefulWidget {
  @override
  PageAccueilState createState() => PageAccueilState();
}

class PageAccueilState  extends State<PageAccueil>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff0b1d31),
        appBar: AppBar(
          leading: InkWell(
            splashColor: Colors.white, // Splash color
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilPage())
              );
            },
            child: Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                splashColor: Colors.white, // Splash color
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageAccueil())
                  );
                },
                child: Image(
                  width: 30,
                  height: 30,
                  image: Svg('assets/chat.svg'),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
          ],
        ),
      ),

    );
  }
}
