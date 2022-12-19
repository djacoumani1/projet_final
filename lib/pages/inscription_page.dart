import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:projet_final/models/utilisateur.dart';
import 'package:projet_final/widgets/logo_nom.dart';
import '../bd/bd.dart';
import '../widgets/alert.dart';
import '../widgets/alertError.dart';
import '../widgets/proprietaire.dart';


class InscriptionPage extends StatefulWidget {
  @override
  InscriptionPageState createState() => InscriptionPageState();
}

class InscriptionPageState  extends State<InscriptionPage> with SingleTickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.decelerate,
  );
  final key = GlobalKey<InscriptionPageState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  final prenom = TextEditingController();
  final nom = TextEditingController();
  final identifiant = TextEditingController();
  final mdp = TextEditingController();
  bool _validatePrenom = false;
  bool _validateNom = false;
  bool _validateIdentifiant = false;
  bool _validateMdp = false;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Color(0xff0b1d31),
        body: FadeTransition(
          opacity: _controller,
          child: SizeTransition(
            key: UniqueKey(),
            sizeFactor: _animation,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 350, 0),
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
                  padding: const EdgeInsets.all(40),
                  child: Text("INSCRIPTION", style: TextStyle(
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
                      errorText: _validateIdentifiant ? 'Renseignez l"identifiant SVP' : null,
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
                    icon: Icon(Icons.save,),
                    backgroundColor:Colors.blueAccent,
                    onPressed: () async{
                      //premiere validation case vide
                      if(!nom.text.isEmpty && !prenom.text.isEmpty && !identifiant.text.isEmpty && !mdp.text.isEmpty){
                        await DB.instance.utilisateurExistant(identifiant.text).then((utilisateur) async {
                          //deuxieme validation identifiant existant
                          if(utilisateur == null){
                            await DB.instance.insert(Utilisateurs(prenom: prenom.text, nom: nom.text, identifiant: identifiant.text, mdp: mdp.text));
                            showAlertDialog(context);
                          }
                          else{
                            Future.delayed(Duration.zero, () => showAlert(context, "Identifiant deja existant !"));
                          }

                        }).catchError((error){
                          print(" Erreur dans la base de donnee ");
                        });


                      }
                      setState(() {
                        if(prenom.text.isEmpty){
                          prenom.text.isEmpty ? _validatePrenom = true : _validatePrenom = false;
                        }
                        if(nom.text.isEmpty){
                          nom.text.isEmpty ? _validateNom = true : _validateNom = false;
                        }
                        if(identifiant.text.isEmpty){
                          identifiant.text.isEmpty ? _validateIdentifiant = true : _validateIdentifiant = false;
                        }
                        if(mdp.text.isEmpty){
                          mdp.text.isEmpty ? _validateMdp = true : _validateMdp = false;
                        }
                        nom.clear();
                        prenom.clear();
                        identifiant.clear();
                        mdp.clear();
                      }
                      );
                    }, label: Text("CONFIRMER"),
                ),
                ),
                Logo_nom(),

              ],
            ),
          ),
        ),
      ),

    );
  }
  }
