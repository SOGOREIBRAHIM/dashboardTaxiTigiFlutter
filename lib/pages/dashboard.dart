import 'package:dashboard1/config/configurationCouleur.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dashboard1/models/driverModel.dart';
import 'package:dashboard1/global/global.dart';
import 'package:dashboard1/models/userModel.dart';





class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


   static Future<void> getCompteDrivers() async {

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
    print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
    print('Number of drivers: ${listDriver.length}');
    
  });

  

  }
    
  }

   static Future<void> getCompteUsers() async {
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");

    final snap = await usersRef.once();
    if(snap.snapshot.value != null){
      listUsers = [];
      Map<dynamic, dynamic> usersMap = snap.snapshot.value as Map<dynamic, dynamic>;

    usersMap.forEach((key, value) {
    print('ID: $key');
    UserModel userModel = UserModel(
      id: key,
      nom: value["nom"],
      prenom: value["prenom"],
      phone: value["numero"],
      email: value["email"]
    ); 

    listUsers.add(userModel);
    
  });

  

    }
    
  }



  int choixIndex = 0;

  Map<String, double> dataMap = {
    "Chauffeurs Activés" : 18.47,
    "Chauffeurs Désactivés" : 68.47,
    "Total Chauffeurs" : 18.47,
  };

  Map<String, double> dataMapReservation = {
    "Réservation effectuées" : 20,
    "Réservation en attente" : 30,
    "Total Réservation" : 50,
  };

  List<Color> colorList = [
    const Color(0xffD95AF3),
    Color.fromARGB(255, 202, 243, 90),
    Color.fromARGB(255, 243, 159, 90),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCompteUsers().then((value) {
      setState(() {
        
      });
    });
    getCompteDrivers().then((value) {
      setState(() {
        
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 30,),
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Container(
                    height: 150,
                    width: 270,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: MesCouleur().couleurPrincipal,
                              spreadRadius: 1,
                              blurRadius: 2)
                        ],
                        color: Color.fromARGB(255, 232, 253, 140),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("${listDriver.length}", style: TextStyle(fontSize: 70, color: Colors.blue),),
                                  SizedBox(width: 70,),
                                  CircleAvatar(
                          // backgroundImage: AssetImage("assets/images/1.png"),
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: Image.asset("assets/icons/drivers.png",width: 50,)
                              ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("Nombre de conducteurs connectés", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                  ),
                ),
            // SizedBox(width: 10,),
               Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 150,
                    width: 270,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: MesCouleur().couleurPrincipal,
                              spreadRadius: 1,
                              blurRadius: 2)
                        ],
                        color: Color(0xFFFFD6DC),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("${listUsers.length}", style: TextStyle(fontSize: 70, color: Colors.blue),),
                                  SizedBox(width: 70,),
                                  CircleAvatar(
                          // backgroundImage: AssetImage("assets/images/1.png"),
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: Image.asset("assets/icons/passenger.png",width: 90,)
                              ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("Nombre de passagers connectés", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                  ),
                ),
              SizedBox(width: 50,),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    height: 150,
                    width: 270,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: MesCouleur().couleurPrincipal,
                              spreadRadius: 1,
                              blurRadius: 2)
                        ],
                        color: Color(0xFFD8FAE7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("38 ", style: TextStyle(fontSize: 70, color: Colors.blue),),
                                  SizedBox(width: 70,),
                                  CircleAvatar(
                          // backgroundImage: AssetImage("assets/images/1.png"),
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: Image.asset("assets/icons/reservation.png",width: 50,)
                              ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("Nombre de réservation effectuées", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                  ),
                ),
              
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Container(
                    height: 350,
                      width: 500,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 107, 105, 105),
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: PieChart(
                        dataMap: dataMap,
                        colorList: colorList,
                        chartRadius: MediaQuery.of(context).size.width/2,
                        centerText: "Chauffeurs",
                        chartValuesOptions: ChartValuesOptions(
                          showChartValues: true,
                          showChartValuesOutside: true,
                          showChartValuesInPercentage: true 
                          ),
                      ),
                  ),
                  SizedBox(width: 30,),
                  Container(
                    height: 350,
                      width: 500,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 107, 105, 105),
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                        
                    child: PieChart(
                        dataMap: dataMapReservation,
                        colorList: colorList,
                        chartRadius: MediaQuery.of(context).size.width/2,
                        centerText: "Reservations",
                        chartValuesOptions: ChartValuesOptions(
                          showChartValues: true,
                          showChartValuesOutside: true,
                          showChartValuesInPercentage: true 
                          ),
                      ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}


