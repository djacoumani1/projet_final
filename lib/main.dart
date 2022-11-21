import 'package:flutter/material.dart';
import 'package:projet_final/widgets/connexion_button.dart';
import 'package:projet_final/widgets/logo_nom.dart';
import 'package:projet_final/widgets/proprietaire.dart';
import 'dart:ui';
import 'dart:core';
import 'widgets/inscription_button.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyHomePage createState() => MyHomePage();
}

class MyHomePage extends State<MyApp> with TickerProviderStateMixin {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff0b1d31),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 100, 10, 0),
              child: Logo_nom(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 150, 0, 0),
              child: ConnexionButton(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
              child: InscriptionButton(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 300, 0, 0),
              child: SouleymaneSoumare(),
            )
          ],
        ),
      ),

    );
  }
}


