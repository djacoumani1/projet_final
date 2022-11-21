class Utilisateurs {
  final int? id;
  final String prenom;
  final String nom;
  final String identifiant;
  final String mdp;

  Utilisateurs({
    this.id,
    required this.prenom,
    required this.nom,
    required this.identifiant,
    required this.mdp,
  });

  factory Utilisateurs.fromMap(Map<String, dynamic> json)=> new Utilisateurs(
    id: json['id'],
    prenom: json['prenom'],
    nom: json['nom'],
    identifiant: json['identifiant'],
    mdp: json['mdp'],
  );


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prenom': prenom,
      'nom': nom,
      'identifiant': identifiant,
      'mdp':mdp,
    };
  }

  @override
  String toString() {
    return 'Utilisateur {id: $id,prenom: $prenom, nom: $nom, identifiant: $identifiant, mdp:$mdp}';
  }
}