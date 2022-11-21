import 'package:flutter/material.dart';
import 'package:projet_final/pages/page_accueil.dart';
import 'package:projet_final/widgets/logo_nom.dart';
import '../bd/bd.dart';
import '../models/utilisateur.dart';
import '../widgets/alertError.dart';
import 'inscription_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnexionPage extends StatefulWidget {
  @override
  ConnexionPageState createState() => ConnexionPageState();
}

class ConnexionPageState  extends State<ConnexionPage>{
  Future<SharedPreferences> _prefs  =SharedPreferences.getInstance();
  final identifiant = TextEditingController();
  final mdp = TextEditingController();

  Future donneessauvegarder(Utilisateurs utilisateur) async{
    final SharedPreferences _sharedpref = await _prefs;
    _sharedpref.setInt("id", utilisateur.id!);
    _sharedpref.setString("prenom", utilisateur.prenom);
    _sharedpref.setString("nom", utilisateur.nom);
    _sharedpref.setString("identifiant", utilisateur.identifiant);
    _sharedpref.setString("mdp", utilisateur.mdp);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Color(0xff0b1d31),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(80),
              child: Text("CONNEXION", style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900
              ),),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: identifiant,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(color: Colors.transparent)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Color(0xff58d1ff))
                  ),
                  prefixIcon: Icon(Icons.person_pin, color: Colors.grey,),
                  hintText: "IDENTIFIANT",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: mdp,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(color: Colors.transparent)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Color(0xff58d1ff))
                  ),
                  prefixIcon: Icon(Icons.password, color: Colors.grey,),
                  hintText: "MOT DE PASSE",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: FloatingActionButton.extended(
                icon: Icon(Icons.save,),
                backgroundColor:Colors.blueAccent,
                onPressed: () async{
                  await DB.instance.connexion(identifiant.text, mdp.text).then((utilisateur){
                    if(utilisateur != null){
                      donneessauvegarder(utilisateur).whenComplete((){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PageAccueil())
                        );
                      });
                    }
                    else{
                      Future.delayed(Duration.zero, () => showAlert(context, "Utilisateur non reconnu !"));
                    }

                  }).catchError((error){
                    print(" Erreur dans la base de donnee ");
                  });
                }, label: Text("VALIDER"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Pas de compte ?",style: TextStyle(
                    color: Colors.white
                ),
                ),
                TextButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InscriptionPage())
                  );
                }, child: Text("INSCRIVEZ VOUS",style: TextStyle(
                    color: Colors.blue
                ),
                )
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Logo_nom(),
            ),

          ],
        ),
      ),

    );
  }
}
