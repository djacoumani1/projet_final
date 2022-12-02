import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:projet_final/models/utilisateur.dart';
import 'package:projet_final/pages/profil_twitt.dart';
import 'package:projet_final/widgets/logo_nom.dart';
import '../bd/bd.dart';
import '../widgets/alert.dart';
import '../widgets/alertError.dart';
import '../widgets/proprietaire.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/list_twitt_perso.dart';

class ProfilPage extends StatefulWidget {
  @override
  ProfilPageState createState() => ProfilPageState();
}

class ProfilPageState  extends State<ProfilPage>{

  final prenom = TextEditingController();
  final nom = TextEditingController();
  final identifiant = TextEditingController();
  final mdp = TextEditingController();
  bool _validatePrenom = false;
  bool _validateNom = false;
  bool _validateMdp = false;
  Future<SharedPreferences> _prefs  =SharedPreferences.getInstance();
  int idShared=0;

  @override
  void initState(){
    super.initState();
    utilisateurSauvegarde();
  }

  Future<void> utilisateurSauvegarde() async{
    final SharedPreferences _sharedpref = await _prefs;
    setState(() {
      idShared = _sharedpref.getInt("id")!;
      prenom.text = _sharedpref.getString("prenom")!;
      nom.text = _sharedpref.getString("nom")!;
      identifiant.text = _sharedpref.getString("identifiant")!;
      mdp.text = _sharedpref.getString("mdp")!;
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Color(0xff0b1d31),
        body: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 70, 350, 0),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image
                      (
                      width: 40,
                      height: 40,
                      image: Svg('assets/retour.svg'),
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(350, 65, 0, 0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilTwittPage())
                      );
                    },
                    child: Image.asset("assets/user-contact-list.png", color: Colors.white,)
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(40),
              child: Text("PROFIL", style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900
              ),),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: prenom,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(color: Colors.transparent)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Color(0xff58d1ff))
                  ),
                  prefixIcon: Icon(Icons.person_outline, color: Colors.grey,),
                  hintText: "PRENOM",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  errorText: _validatePrenom ? 'Renseignez le prénom SVP' : null,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: nom,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(color: Colors.transparent)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Color(0xff58d1ff))
                  ),
                  prefixIcon: Icon(Icons.person_outline, color: Colors.grey,),
                  hintText: "NOM",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  errorText: _validateNom ? 'Renseignez le nom SVP' : null,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: identifiant,
                readOnly: true,
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
                  errorText: _validateMdp ? 'Renseignez le mot de passe SVP' : null,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: FloatingActionButton.extended(
                icon: Icon(Icons.update,),
                backgroundColor:Colors.deepPurple,
                onPressed: () async{
                  //premiere validation case vide
                  if(!nom.text.isEmpty && !prenom.text.isEmpty && !identifiant.text.isEmpty && !mdp.text.isEmpty){
                    await DB.instance.update(Utilisateurs(id:idShared,prenom: prenom.text, nom: nom.text, identifiant: identifiant.text, mdp: mdp.text));
                    showAlert(context, "Mise a jour du profil effectué avec succes");
                  }
                  setState(() {
                    if(prenom.text.isEmpty){
                      prenom.text.isEmpty ? _validatePrenom = true : _validatePrenom = false;
                    }
                    if(nom.text.isEmpty){
                      nom.text.isEmpty ? _validateNom = true : _validateNom = false;
                    }

                    if(mdp.text.isEmpty){
                      mdp.text.isEmpty ? _validateMdp = true : _validateMdp = false;
                    }
                  }
                  );
                }, label: Text("MODIFIER"),
              ),
            ),
            Logo_nom(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: SouleymaneSoumare(),
            )
          ],
        ),
      ),

    );
  }
}
