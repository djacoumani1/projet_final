import 'package:flutter/material.dart';
import 'package:projet_final/models/twitt.dart';
import '../bd/bd.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    curve: Curves.fastOutSlowIn,
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
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Icon(Icons.delete),
                                ),
                                key: ValueKey<int>(snapshot.data![index].id!),
                                onDismissed: (direction) async {
                                  if (direction == DismissDirection.startToEnd){
                                    await DB.instance.delete(snapshot.data![index].id!);
                                    snapshot.data!.remove(snapshot.data![index]);
                                    setState(() {

                                    });
                                  }
                                },
                                child: Card(
                                  margin: EdgeInsets.fromLTRB(0, 1.5, 0, 0),
                                  child: ListTile(
                                    hoverColor: Color(0xff58d1ff),
                                    selectedTileColor: Color(0xff58d1ff),
                                    onTap: () {
                                    },
                                    title: Text(tweet.twitt,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                        )
                                    ),
                                    leading: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),

                                  ),
                                ),
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
