import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:projet_final/models/twitt.dart';
import 'package:projet_final/widgets/logo_nom.dart';
import '../bd/bd.dart';
import '../widgets/alertError.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NouveauTwittPage extends StatefulWidget {
  @override
  NouveauTwittPageState createState() => NouveauTwittPageState();
}

class NouveauTwittPageState  extends State<NouveauTwittPage>{

  final twitt = TextEditingController();
  bool _validateTwitt = false;
  Future<SharedPreferences> _prefs  =SharedPreferences.getInstance();
  int idShared=0;
  String pseudo='';

  @override
  void initState(){
    super.initState();
    utilisateurSauvegarde();
  }

  Future<void> utilisateurSauvegarde() async{
    final SharedPreferences _sharedpref = await _prefs;
    setState(() {
      idShared = _sharedpref.getInt("id")!;
      pseudo = _sharedpref.getString("identifiant")!;
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
              padding: const EdgeInsets.all(40),
              child: Text("NOUVEAU TWITT", style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900
              ),),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 50),
              child: TextFormField(
                controller: twitt,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide: BorderSide(color: Colors.transparent)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Color(0xff58d1ff))
                  ),
                  hintText: "NOUVEAU TWITT",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),

                  fillColor: Colors.white,
                  filled: true,
                  errorText: _validateTwitt ? 'tweet vide ??' : null,
                ),
                maxLines: 5,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: FloatingActionButton.extended(
                icon: Icon(Icons.add_circle_outline,),
                backgroundColor:Colors.blueAccent,
                onPressed: () async{
                  //premiere validation case vide
                  if(!twitt.text.isEmpty){
                    await DB.instance.insertTwitt(Twitts(pseudo: pseudo, twitt: twitt.text, utilisateurId: idShared, like: 0, unlike: 0));
                    showAlert(context, "Nouveau twitt en ligne");
                  }
                  setState(() {
                    if(twitt.text.isEmpty){
                      twitt.text.isEmpty ? _validateTwitt = true : _validateTwitt = false;
                    }
                  }
                  );
                }, label: Text("AJOUTER"),
              ),
            ),
            Logo_nom(),

          ],
        ),
      ),

    );
  }
}
