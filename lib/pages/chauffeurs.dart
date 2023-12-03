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
              padding: const EdgeInsets.only(left: 8,top: 50),
              child: Container(
                // width: 1200,
                // height: 80,
                 child: Padding(
                   padding:  EdgeInsets.all(20.0),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                     Text(
                      "Liste des chauffeurs",
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: MesCouleur().couleurPrincipal),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 2000,
                      child: Divider(height: 1, thickness: 1, color: MesCouleur().couleurPrincipal)),
                  ],
                   ),
                   
                 ),
              ),
            ),
            
            Container(
              
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ), 
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: listDriver.length,
                itemBuilder: (context, index){
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Container(
                       height: 10,
                       width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 250, 238, 238),
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
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                                        // backgroundImage: AssetImage("assets/images/1.png"),
                                  radius: 40,
                                  backgroundColor: MesCouleur().couleurPrincipal,
                                  child: Text("${listDriver [index].nom![0].toUpperCase()}.${listDriver [index].prenom!.toUpperCase()[0]}", style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)
                                ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 30,),
                                Row(
                                  children: [
                                    Icon(Icons.person, color: MesCouleur().couleurPrincipal,),
                                    SizedBox(width: 20,),
                                    Text(
                                      "${listDriver[index].prenom}"
                                    ),
                                  ],
                                ),
                                SizedBox(height: 0,),
                                Row(
                                  children: [
                                    Icon(Icons.person, color: MesCouleur().couleurPrincipal,),
                                    SizedBox(width: 20,),
                                    Text(
                                      "${listDriver[index].nom}"
                                    ),
                                  ],
                                ),
                                SizedBox(height: 0,),
                                Row(
                                  children: [
                                    Icon(Icons.phone_android, color: MesCouleur().couleurPrincipal,),
                                    SizedBox(width: 20,),
                                    Text(
                                      "${listDriver[index].phone}"
                                    ),
                                  ],
                                ),
                                SizedBox(height: 0,),
                                Row(
                                  children: [
                                    Icon(Icons.email, color: MesCouleur().couleurPrincipal,),
                                    SizedBox(width: 20,),
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