import 'package:dashboard1/config/configurationCouleur.dart';
import 'package:dashboard1/global/global.dart';
import 'package:dashboard1/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class Passagers extends StatefulWidget {
  const Passagers({super.key});

  @override
  State<Passagers> createState() => _PassagersState();
}

class _PassagersState extends State<Passagers> {
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");

    static Future<void> getAllUsers() async {
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
                      "Liste des reservations",
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
                itemCount: listUsers.length,
                itemBuilder: (context, index){
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.all(35.0),
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
                                  child: Text("${listUsers [index].nom![0].toUpperCase()}.${listUsers [index].prenom!.toUpperCase()[0]}", style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)
                                ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 25,),
                                Text(
                                  "${listUsers[index].prenom}"
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  "${listUsers[index].prenom}"
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "${listUsers[index].email}"
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




