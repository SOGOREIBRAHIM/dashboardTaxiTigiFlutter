
import 'package:firebase_database/firebase_database.dart';

class ReservationModel {
  int? destination;
  String? originAdress;
  int? time;
  String? name;
  int? phone;


  ReservationModel({
    this.destination,
    this.originAdress,
    this.time,
    this.phone,
    this.name
  });

  ReservationModel.fromSnapshot(DataSnapshot snap){
   
    originAdress = (snap.value as dynamic)["originAdress"];
    destination = (snap.value as dynamic)["destinationAdress"];
    time = (snap.value as dynamic)["time"];
    phone = (snap.value as dynamic)["phone"];
    name = (snap.value as dynamic)["numero"];
  }

  


}