class Twitts {
  final int? id;
  final String pseudo;
  final String twitt;
  int like;
  int unlike;
  final String? date;
  final int utilisateurId;

  Twitts({
    this.id,
    required this.pseudo,
    required this.twitt,
    required this.like,
    required this.unlike,
    this.date,
    required this.utilisateurId,
  });

  factory Twitts.fromMap(Map<String, dynamic> json)=> new Twitts(
    id: json['id'],
    pseudo: json['pseudo'],
    twitt: json['twitt'],
    like:json['like'],
    unlike:json['unlike'],
    date: json['date'],
    utilisateurId: json['utilisateurId']
  );


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pseudo': pseudo,
      'twitt': twitt,
      'like':like,
      'unlike':unlike,
      'date': date,
      'utilisateurId':utilisateurId,
    };
  }

}