import 'package:dashboard1/config/configurationCouleur.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int choixIndex = 0;

  Map<String, double> dataMap = {
    "Chauffeurs Activés" : 18.47,
    "Chauffeurs Désactivés" : 68.47,
    "Chauffeurs Total" : 18.47,
  };

  List<Color> colorList = [
    const Color(0xffD95AF3),
    Color.fromARGB(255, 202, 243, 90),
    Color.fromARGB(255, 243, 159, 90),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Container(
                    height: 150,
                    width: 270,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 107, 105, 105),
                              spreadRadius: 1,
                              blurRadius: 5)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("57 ", style: TextStyle(fontSize: 60, color: Colors.blue),),
                                  SizedBox(width: 70,),
                                  CircleAvatar(
                          // backgroundImage: AssetImage("assets/images/1.png"),
                                radius: 50,
                                backgroundColor: MesCouleur().couleurPrincipal,
                                child: Image.asset("assets/icons/moto.png")
                              ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("Conducteur de moto en ligne", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                  ),
                ),
            
               Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Container(
                    height: 150,
                    width: 270,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 107, 105, 105),
                              spreadRadius: 1,
                              blurRadius: 5)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("19 ", style: TextStyle(fontSize: 60, color: Colors.blue),),
                                  SizedBox(width: 70,),
                                  CircleAvatar(
                          // backgroundImage: AssetImage("assets/images/1.png"),
                                radius: 50,
                                backgroundColor: MesCouleur().couleurPrincipal,
                                child: Image.asset("assets/icons/car.png")
                              ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("Conducteurs Economique en ligne", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                  ),
                ),
            
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Container(
                    height: 150,
                    width: 270,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 107, 105, 105),
                              spreadRadius: 1,
                              blurRadius: 5)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("38 ", style: TextStyle(fontSize: 60, color: Colors.blue),),
                                  SizedBox(width: 70,),
                                  CircleAvatar(
                          // backgroundImage: AssetImage("assets/images/1.png"),
                                radius: 50,
                                backgroundColor: MesCouleur().couleurPrincipal,
                                child: Image(image: AssetImage("assets/icons/4.png"),),
                              ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("Conducteurs Prenium en ligne", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
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
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}


