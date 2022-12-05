import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:projet_final/widgets/logo_nom.dart';
import '../bd/bd.dart';
import '../models/twitt.dart';
import '../widgets/alertError.dart';
import 'nouveau_twitt_page.dart';
import 'profilpage.dart';

class PageAccueil extends StatefulWidget {
  @override
  PageAccueilState createState() => PageAccueilState();
}

class PageAccueilState  extends State<PageAccueil> with SingleTickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceInOut,
  );
  final key = GlobalKey<PageAccueilState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NouveauTwittPage())
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add_rounded),
        ),
        body: Column(
          children: [
            Flexible(
              child: FutureBuilder<List<Twitts>>(
                  future: DB.instance.allTwitt(),
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
                               Container(
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
                                            ),),
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
      ),

    );
  }
}
