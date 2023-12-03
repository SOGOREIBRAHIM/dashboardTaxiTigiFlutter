import 'package:dashboard1/config/configurationCouleur.dart';
import 'package:dashboard1/models/reservation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {

  // Recperation de la liste Administrateur
  static Future<void> getAllReservation() async {

    DatabaseReference reservationRef = FirebaseDatabase.instance.ref().child("All Ride Request");
    final snap = await reservationRef.once();

    if(snap.snapshot.value != null){
      Map<dynamic, dynamic> reservationMap = snap.snapshot.value as Map<dynamic, dynamic>;

    List listReservation = [];

    reservationMap.forEach((key, value) {
    print('ID: $key');
    ReservationModel reservationModel = ReservationModel(
      destination: value["destinationAdress"],
      originAdress: value["originAdress"],
      phone: value["userphone"],
      name: value["name"]
    ); 

    listReservation.add(reservationModel);
    print("List rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    print(listReservation);
    
  });

  

  }
    
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllReservation().then((value) {
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
              padding: EdgeInsets.only(left: 14,top: 50),
              child: Container(
                // width: 1200,
                // height: 80,
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                      "Liste des réservations",
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: MesCouleur().couleurPrincipal),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: 1100,
                      child: Divider(height: 1, thickness: 1, color: MesCouleur().couleurPrincipal)),
                  ],
                 ),
              ),
            ),
            
            Container(
              
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ), 
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index){
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Container(
                       height: 10,
                       width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.yellow.shade100,
                            boxShadow:  [
                             BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 2)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            CircleAvatar(
                          // backgroundImage: AssetImage("assets/images/1.png"),
                                radius: 50,
                                backgroundColor: Colors.white,
                                 child: Image(image: AssetImage("assets/icons/taxi.png",),)
                              ),
                           
                            Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      Icon(Icons.location_pin,color: Colors.blue,),
                                      SizedBox(width: 50,),
                                      Text(
                                        "Amdallaye ACI 2000", style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      
                                      Icon(Icons.location_searching, color: Colors.red,),
                                      SizedBox(width: 50,),
                                      Text(
                                        "Magnambougou projet", style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Icon(Icons.car_crash,color: Colors.orange,),
                                      SizedBox(width: 50,),
                                      Text(
                                        "Economique",style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Icon(Icons.attach_money,color: Colors.purpleAccent,),
                                      SizedBox(width: 50,),
                                      Text(
                                        "2000 FCFA",style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              ),
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