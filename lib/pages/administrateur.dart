import 'package:dashboard1/config/configurationCouleur.dart';
import 'package:dashboard1/pages/dashboard.dart';
import 'package:flutter/material.dart';

class Administrateur extends StatefulWidget {
  const Administrateur({super.key});

  @override
  State<Administrateur> createState() => _AdministrateurState();
}

class _AdministrateurState extends State<Administrateur> {
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
                              child: CircleAvatar(
                                                        // backgroundImage: AssetImage("assets/images/1.png"),
                                  radius: 40,
                                  backgroundColor: MesCouleur().couleurPrincipal,
                                  child: Icon(Icons.person,size: 50,)
                                ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 35,),
                                Text(
                                  "Ibrahim SOGORE", style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "+223 77 65 55 67", style: TextStyle(),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "sogoreibrahim135@gmail.com"
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    
                                    GestureDetector(
                                      onTap: (){
                                        // Navigator.push(context, MaterialPageRoute(builder: (index)=> Dashboard()));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                        borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.blue,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 187, 187, 187),
                                                  spreadRadius: 0,
                                                  blurRadius: 1,
                                                )
                                              ]),
                                        child: Icon(Icons.create, color: Colors.white,)),
                                    ),
                                    SizedBox(width: 20,),
                                    GestureDetector(
                                      onTap: (){
                                        // Navigator.push(context, MaterialPageRoute(builder: (index)=> Dashboard()));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                        borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.red,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 187, 187, 187),
                                                  spreadRadius: 0,
                                                  blurRadius: 1,
                                                )
                                              ]),
                                        child: Icon(Icons.delete, color: Colors.white,)),
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