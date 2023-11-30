
import 'package:firebase_database/firebase_database.dart';

class DriverModel {
  String? id;
  String? nom;
  String? prenom;
  String? phone;
  String? email;


  DriverModel({
    this.id,
    this.nom,
    this.prenom,
    this.email,
    this.phone
  });

  DriverModel.fromSnapshot(DataSnapshot snap){
    id = snap.key;
    nom = (snap.value as dynamic)["nom"];
    prenom = (snap.value as dynamic)["prenom"];
    email = (snap.value as dynamic)["email"];
    phone = (snap.value as dynamic)["numero"];
  }

  @override
  String toString() {
    return 'DriverModel(id: $id, nom: $nom, prenom: $prenom, phone: $phone, email: $email)';
  }


}