class Twitts {
  final int? id;
  final String pseudo;
  final String twitt;
  final String? date;
  final int utilisateurId;

  Twitts({
    this.id,
    required this.pseudo,
    required this.twitt,
    this.date,
    required this.utilisateurId,
  });

  factory Twitts.fromMap(Map<String, dynamic> json)=> new Twitts(
    id: json['id'],
    pseudo: json['pseudo'],
    twitt: json['twitt'],
    date: json['date'],
    utilisateurId: json['utilisateurId']
  );


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pseudo': pseudo,
      'twitt': twitt,
      'date': date,
      'utilisateurId':utilisateurId,
    };
  }

}