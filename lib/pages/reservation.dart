import 'package:dashboard1/config/configurationCouleur.dart';
import 'package:flutter/material.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
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
                        "Liste des passagers",
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
                  crossAxisCount: 3,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ), 
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Container(
                       height: 10,
                       width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow:  [
                              BoxShadow(
                                color: Color.fromARGB(255, 187, 187, 187),
                                spreadRadius: 2,
                                blurRadius: 1,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: 1, top: 10),
                              child: Image(image: AssetImage("assets/icons/4.png"),)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 35,),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined),
                                      SizedBox(width: 50,),
                                      Text(
                                        "Amdallaye ACI 2000", style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Icon(Icons.location_city),
                                      SizedBox(width: 50,),
                                      Text(
                                        "Magnambougou projet", style: TextStyle(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Icon(Icons.car_crash_outlined),
                                      SizedBox(width: 50,),
                                      Text(
                                        "Economique"
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Icon(Icons.attach_money),
                                      SizedBox(width: 50,),
                                      Text(
                                        "2000 FCFA"
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