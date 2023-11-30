import 'package:dashboard1/config/configurationCouleur.dart';
import 'package:flutter/material.dart';

class Passagers extends StatefulWidget {
  const Passagers({super.key});

  @override
  State<Passagers> createState() => _PassagersState();
}

class _PassagersState extends State<Passagers> {
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
                  childAspectRatio: 2,
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
                       height: 50,
                       width: 100,
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
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                                        // backgroundImage: AssetImage("assets/images/1.png"),
                                  radius: 40,
                                  backgroundColor: MesCouleur().couleurPrincipal,
                                  child: Icon(Icons.person,size: 50,)
                                ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 25,),
                                Text(
                                  "Ibrahim SOGORE"
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  "+223 83 52 28 56"
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "sogoreibrahim135@gmail.com"
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