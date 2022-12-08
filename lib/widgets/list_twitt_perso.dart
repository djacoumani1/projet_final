import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:projet_final/models/twitt.dart';
import '../bd/bd.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/page_accueil.dart';

class TwittPersoPage extends StatefulWidget {
  @override
  TwittPersoPageState createState() => TwittPersoPageState();
}

class TwittPersoPageState  extends State<TwittPersoPage> with SingleTickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linearToEaseOut,
  );
  final key = GlobalKey<TwittPersoPageState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    });

}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 350, 0),
            child: InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageAccueil())
                );
              },
              child: Image
                (
                width: 30,
                height: 30,
                image: Svg('assets/retour.svg'),
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text("Les tweets personnels", style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),),
          ),
          Flexible(
            child: FutureBuilder<List<Twitts>>(
                future: DB.instance.twitteById(idShared),
                builder: (BuildContext context, AsyncSnapshot<List<Twitts>> snapshot) {

                  if (!snapshot.hasData) {
                    return Center( child: CircularProgressIndicator());
                  }
                  return snapshot.data!.isEmpty
                      ? Center(child: Text("Aucun tweet avec ce compte pour l'instant ", style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),)):
                  AnimatedList(
                      key: key,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      initialItemCount: snapshot.data!.length,
                      itemBuilder: (context, index, animation) {
                        Twitts tweet = snapshot.data![index];
                        return SizeTransition(
                          key: UniqueKey(),
                          sizeFactor: _animation,
                          child: Column(
                            children: [
                              Dismissible(
                                //direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                  child: Icon(Icons.delete),
                                ),
                                key: ValueKey<int>(snapshot.data![index].id!),
                                onDismissed: (direction) async {
                                    await DB.instance.delete(snapshot.data![index].id!);
                                    snapshot.data!.remove(snapshot.data![index]);
                                    setState(() {
                                    });
                                },
                                child: Container(
                                  height: 130,
                                  child: Card(
                                    color: Colors.transparent,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                     ListTile(
                                    leading: Icon(Icons.person,
                                    size: 50,
                                    color: Colors.white,),
                                    title: Text(tweet.pseudo,style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),),
                                    subtitle: Text(tweet.twitt, style: TextStyle(
                                      color: Colors.white
                                    ),
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                  TextButton(
                                  child: Row(
                                    children: [
                                      const Icon(Icons.thumb_up_sharp, color: Colors.grey,),
                                      Text(tweet.like.toString(), style: TextStyle(
                                          color: Colors.grey
                                      ),),
                                    ],
                                  ),
                                  onPressed: () async {
                                    tweet.like++;
                                    await DB.instance.updateLike(tweet);
                                    setState(() {
                                    });
                                  }
                              ),
                              const SizedBox(width: 8),
                                  TextButton(
                                    child: Row(
                                      children: [
                                        const Icon(Icons.thumb_down_sharp, color: Colors.grey,),
                                        Text(tweet.unlike.toString(), style: TextStyle(
                                            color: Colors.grey
                                        ),),
                                      ],
                                    ),
                                    onPressed: () async {
                                      tweet.unlike++;
                                      await DB.instance.updateLike(tweet);
                                      setState(() {
                                      });
                                },
                                  ),
                                  const SizedBox(width: 8),
                              ],
                          ),
                                        ],
                                    ),
                                  ),
                                ),//aa
                              ),
                            ],
                          ),
                        );
                      }
                  );

                }
            ),
          ),
        ],
      ),

    );
  }
}
