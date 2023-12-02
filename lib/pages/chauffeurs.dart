import 'package:dashboard1/config/configurationCouleur.dart';
import 'package:dashboard1/global/global.dart';
import 'package:dashboard1/models/driverModel.dart';
import 'package:dashboard1/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';


class Chauffeurs extends StatefulWidget {
  const Chauffeurs({super.key});

  @override
  State<Chauffeurs> createState() => _ChauffeursState();
}

class _ChauffeursState extends State<Chauffeurs> {

  DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");

  static Future<void> getAllUsers() async {

    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    final snap = await driversRef.once();

    if(snap.snapshot.value != null){
      Map<dynamic, dynamic> driversMap = snap.snapshot.value as Map<dynamic, dynamic>;

      listDriver = [];
    driversMap.forEach((key, value) {
    print('ID: $key');
    DriverModel driverModel = DriverModel(
      id: key,
      nom: value["nom"],
      prenom: value["prenom"],
      phone: value["numero"],
      email: value["email"]
    ); 

    listDriver.add(driverModel);
    
  });

  

  }
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers().then((value) {
      setState(() {
      
      });
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40,top: 50),
              child: Container(
                // width: 1200,
                // height: 80,
                 child: Padding(
                   padding:  EdgeInsets.all(16.0),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                        "Liste des chauffeurs",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10,),
                      Divider(height: 1, thickness: 1, color: Colors.black),
                    ],
                   ),
                   
                 ),
              ),
            ),
            
            Container(
              
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.6,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ), 
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: listDriver.length,
                itemBuilder: (context, index){
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Container(
                       height: 50,
                       width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 187, 187, 187),
                                spreadRadius: 2,
                                blurRadius: 1,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: CircleAvatar(
                                                        // backgroundImage: AssetImage("assets/images/1.png"),
                                  radius: 40,
                                  backgroundColor: MesCouleur().couleurPrincipal,
                                  child: Text("${listDriver[index].nom![0].toUpperCase()}", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
                                ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 25,),
                                Row(
                                  children: [
                                    Icon(Icons.person, color: MesCouleur().couleurPrincipal,),
                                    SizedBox(width: 30,),
                                    Text(
                                      "${listDriver[index].nom}"
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Icon(Icons.person, color: MesCouleur().couleurPrincipal,),
                                    SizedBox(width: 30,),
                                    Text(
                                      "${listDriver[index].prenom}"
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Icon(Icons.phone_android, color: MesCouleur().couleurPrincipal,),
                                    SizedBox(width: 30,),
                                    Text(
                                      "${listDriver[index].phone}"
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Icon(Icons.email, color: MesCouleur().couleurPrincipal,),
                                    SizedBox(width: 30,),
                                    Text(
                                      "${listDriver[index].email}"
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                 } ,
                ),
            )
          ],
        ),
      ),
    );
  }
}