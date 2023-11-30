import 'package:dashboard1/config/configurationCouleur.dart';
import 'package:dashboard1/controller/side_bar_controller.dart';
import 'package:dashboard1/global/global.dart';
import 'package:dashboard1/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class SideBarpage extends StatefulWidget {
  const SideBarpage({super.key, required this.userMap});
  final Map<String,dynamic> userMap;
  @override
  State<SideBarpage> createState() => _SideBarpageState();
}


class _SideBarpageState extends State<SideBarpage> {

  DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");
  // UserModel? userModelCurrentInfo = currentUser as UserModel?;

  @override
  Widget build(BuildContext context) {
    SideBarController sideBarController = Get.put(SideBarController());
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0xFFF5F5F5),
              child: Obx(()=>ListView(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    height: 80,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  SizedBox(height: 30,),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Color.fromARGB(255, 189, 188, 188),
                  ),
                  SizedBox(height: 80,),
                  ListTile(
                    title: Text("Dashboard"),
                    leading: Icon(Icons.dashboard, color: Color.fromARGB(255, 78, 78, 78), size: 30,),
                    onTap: ()=> sideBarController.index.value=0,
                    selected: sideBarController.index.value==0,
                  ),
                  SizedBox(height: 10,),
                  ListTile(
                    title: Text("Réservation"),
                    leading: Image.asset("assets/icons/9.png"),
                    onTap: ()=> sideBarController.index.value=1,
                    selected: sideBarController.index.value==1,
                  ),
                  SizedBox(height: 10,),
                  ListTile(
                    title: Text("Passagers"),
                    leading: Image.asset("assets/icons/8.png"),
                    onTap: ()=> sideBarController.index.value=2,
                    selected: sideBarController.index.value==2,
                  ),
                  SizedBox(height: 10,),
                  ListTile(
                    title: Text("Chauffeurs"),
                    leading: Image.asset("assets/icons/7.png"),
                    onTap: ()=> sideBarController.index.value=3,
                    selected: sideBarController.index.value==3,
                  ),
                  SizedBox(height: 10,),
                  ListTile(
                    title: Text("Administrateur"),
                    leading: Icon(Icons.person, color: Color.fromARGB(255, 78, 78, 78), size: 30,),
                    onTap: ()=> sideBarController.index.value=4,
                    selected: sideBarController.index.value==4,
                  ),
                  SizedBox(height: 70,),
                  ListTile(
                    title: Text("${widget.userMap["nom"]}", style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text("${widget.userMap["prenom"]}", style: TextStyle(fontWeight: FontWeight.bold),),
                    leading: Image.asset("assets/icons/profil.png"),
                    
                  ),
                ],
              ),)
            ),
            
          ),
          Expanded(
            flex: 6,
            child: Obx (
              () => sideBarController.pages[sideBarController.index.value])),
        ],
      ),
    );
  }
}