import 'dart:html';

import 'package:dashboard1/config/configurationCouleur.dart';
import 'package:dashboard1/global/global.dart';
import 'package:dashboard1/models/adminModel.dart';
import 'package:dashboard1/models/driverModel.dart';
import 'package:dashboard1/models/userModel.dart';
import 'package:dashboard1/pages/dashboard.dart';
import 'package:dashboard1/pages/login.dart';
import 'package:dashboard1/side_bar.dart/side_bar_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


class Administrateur extends StatefulWidget {
  const Administrateur({super.key});
  

  @override
  State<Administrateur> createState() => _AdministrateurState();
}

class _AdministrateurState extends State<Administrateur> {

  AdminModel adminModel = AdminModel();

// Controlleurs des TextFormField
  final emailControler = TextEditingController();
  final passControler = TextEditingController();
  final confirmerPassControler = TextEditingController();
  final numControler = TextEditingController();
  final nomControler = TextEditingController();
  final prenomControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passToggle = true;
  bool confirmPassToggle = true;


// Recperation de la liste Administrateur
  static Future<void> getAllUsers() async {

    DatabaseReference adminRef = FirebaseDatabase.instance.ref().child("admin");
    final snap = await adminRef.once();

    if(snap.snapshot.value != null){
      Map<dynamic, dynamic> adminMap = snap.snapshot.value as Map<dynamic, dynamic>;

    listAdmin = [];
    adminMap.forEach((key, value) {
    print('ID: $key');
    AdminModel adminModel = AdminModel(
      id: key,
      nom: value["nom"],
      prenom: value["prenom"],
      phone: value["numero"],
      email: value["email"]
    ); 

    listAdmin.add(adminModel);
    
  });

  

  }
    
  }

// Modifier un administrateur
  static Future updateAdminId(AdminModel admin) async {

    var id = admin.id;
    print("ttttttttttttttttttttttttttttttttt");
    print("admin/$id");
    DatabaseReference adminbRef = FirebaseDatabase.instance.ref().child("admin");

    await adminbRef.child(admin.id!).set({
    "email" : admin.email,
    "nom" : admin.nom,
    "numero" : admin.phone,
    "prenom" : admin.prenom,
    }).then((value) {
      print("End excecution");
      debugPrint("---------------------------------------------");
    }).catchError((onError){
      print(onError.toString());
    });

  //  await FirebaseDatabase.instance.ref().child("admin").child(admin.id!).update(
  //   {
  //   "nom" : admin.nom,
  //   "prenom" : admin.prenom,
  //   "email" : admin.email,
  //   "numero" : admin.phone,
  //   }
  //  );
  //  print("rrrrrrrrrrrrrrrrrrrrrr");

  // await Fluttertoast.showToast(msg: "Inscription reussit !");
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (index) => SideBarpage(userMap: {})));
   
  }

  // Supprimer un administrateur
  static Future deleteAdminId(AdminModel admin) async {


   await FirebaseDatabase.instance.ref().child("admin").child(admin.id!).remove();

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

// Ajouter un Administrateur
  Future<void> addAdmin() async {
    if (_formKey.currentState!.validate()) {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailControler.text.trim(),
              password: passControler.text.trim())
          .then((auth) async {
        currentUser = auth.user;
        if (currentUser != null) {
          Map userMap = {
            "id": currentUser!.uid,
            "nom": nomControler.text.trim(),
            "prenom": prenomControler.text.trim(),
            "numero": numControler.text.trim(),
            "email": emailControler.text.trim(),
            "mot de passe": passControler.text.trim(),
            "confirmer": confirmerPassControler.text.trim(),
          };
          DatabaseReference userRef =
              FirebaseDatabase.instance.ref().child("admin");
          userRef.child(currentUser!.uid).set(userMap);
        }
        await Fluttertoast.showToast(msg: "Inscription reussit !");
        Navigator.push(
            context, MaterialPageRoute(builder: (index) => SideBarpage(userMap: {})));
      }).catchError((errorMessage){
        Fluttertoast.showToast(msg: "Inscription echoué !");
        print(errorMessage.toString());
      });
    }
    else{
      Fluttertoast.showToast(msg: "Remplisser les champs vides !");
    }
  }
 
 // Popup pour ajouter un Admin
  Future showAddAdmin(BuildContext context) async{

    return showDialog(context: context, 
    builder: (context){
      return AlertDialog(
          title: Text("Modifier un admin", style: TextStyle(color: MesCouleur().couleurPrincipal,fontSize: 20),),
          content: SingleChildScrollView(
            child: Container(
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
               children: [
                Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFFEDB602)), // Couleur de la bordure lorsqu'elle est désactivée
                                        ),
                                        labelText: "Nom",
                                        prefixIcon: Icon(Icons.person_2_outlined,
                                            color: Color(0xFFEDB602)),
                                        border: OutlineInputBorder()),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return "Nom ne peut pas etre vide !";
                                      }
                                      if (text.length < 2) {
                                        return "Nom trop court !";
                                      }
                                      if (text.length > 60) {
                                        return "Nom trop long, Maximuin 30 !";
                                      }
                                    },
                                    onChanged: (text) => setState(() {
                                      nomControler.text = text;
                                    }),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFFEDB602)), // Couleur de la bordure lorsqu'elle est désactivée
                                        ),
                                        labelText: "Prenom",
                                        prefixIcon: Icon(Icons.person_2_outlined,
                                            color: Color(0xFFEDB602)),
                                        border: OutlineInputBorder()),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return "Prenom ne peut pas etre vide !";
                                      }
                                      if (text.length < 2) {
                                        return "Prenom trop court !";
                                      }
                                      if (text.length > 60) {
                                        return "Prenom trop long, Maximuin 30 !";
                                      }
                                    },
                                    onChanged: (text) => setState(() {
                                      prenomControler.text = text;
                                    }),
                                  ),
                                  SizedBox(height: 10),
                                  IntlPhoneField(
                                    showCountryFlag: true,
                                    dropdownIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: MesCouleur().couleurPrincipal,
                                    ),
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFFEDB602)), // Couleur de la bordure lorsqu'elle est désactivée
                                        ),
                                        border: OutlineInputBorder()),
                                    initialCountryCode: 'ML',
                                    onChanged: (text) => setState(() {
                                      numControler.text = text.completeNumber;
                                    }),
                                  ),
                                  SizedBox(height: 5),
                                  TextFormField(
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFFEDB602)), // Couleur de la bordure lorsqu'elle est désactivée
                                        ),
                                        labelText: "Email",
                                        prefixIcon: Icon(Icons.email_outlined,
                                            color: Color(0xFFEDB602)),
                                        border: OutlineInputBorder()),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return "Email ne peut pas etre vide !";
                                      }
                                      if (EmailValidator.validate(text)) {
                                        return null;
                                      }
                                      if (text.length < 2) {
                                        return "Email trop court !";
                                      }
                                      if (text.length > 100) {
                                        return "Nom trop long, Maximuin 50 !";
                                      }
                                    },
                                    onChanged: (text) => setState(() {
                                      emailControler.text = text;
                                    }),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(20)
                                    ],
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return "Mot de passe ne peut pas etre vide !";
                                      }
                                      if (text.length < 5) {
                                        return "Entrez mot de passe valide !";
                                      }
                                      if (text.length > 19) {
                                        return "Mot de passe trop long, Maximuin 19 !";
                                      }
                                      return null;
                                    },
                                    obscureText: passToggle,
                                    controller: passControler,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFFEDB602)), // Couleur de la bordure lorsqu'elle est désactivée
                                        ),
                                        labelText: "Mot de passe",
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Color(0xFFEDB602),
                                        ),
                                        suffix: InkWell(
                                          onTap: () {
                                            setState(() {
                                              passToggle = !passToggle;
                                            });
                                          },
                                          child: Icon(
                                            passToggle
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Color(0xFFEDB602),
                                          ),
                                        ),
                                        border: OutlineInputBorder()),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(20)
                                    ],
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return "Confirmer mot de passe ne peut pas etre vide !";
                                      }
                                      if (text.length < 5) {
                                        return "Entrez mot de passe valide !";
                                      }
                                      if (text != passControler.text) {
                                        return "Mot de passe incorrect !";
                                      }
                                      if (text.length > 19) {
                                        return "Confirmer Mot de passe trop long, Maximuin 19 !";
                                      }
                                      return null;
                                    },
                                    obscureText: confirmPassToggle,
                                    controller: confirmerPassControler,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFFEDB602)), // Couleur de la bordure lorsqu'elle est désactivée
                                        ),
                                        labelText: "Confirmer ",
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Color(0xFFEDB602),
                                        ),
                                        suffix: InkWell(
                                          onTap: () {
                                            setState(() {
                                              confirmPassToggle = !confirmPassToggle;
                                            });
                                          },
                                          child: Icon(
                                            passToggle
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Color(0xFFEDB602),
                                          ),
                                        ),
                                        border: OutlineInputBorder()),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    width: 350,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                       await addAdmin();
                                      },
                                      style: ElevatedButton.styleFrom(
                                    backgroundColor: MesCouleur().couleurPrincipal// Définir la couleur du bouton
                                    // Vous pouvez également personnaliser d'autres propriétés ici
                                  ),
                                      child: Text(
                                        'S\'inscrire',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(255, 255, 255, 255),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                  ], 
              ),
            ),
          ),
        );
    }
    );
  }

  // Popup pour modifier un admin
  Future updateAdmin(BuildContext context, AdminModel adminModel) async{
    
     // methode popup ajout admin
    return showDialog(context: context, 
    builder: (context){
      nomControler.text = adminModel.nom!;
      prenomControler.text = adminModel.prenom!;
      emailControler.text = adminModel.email!;
      numControler.text = adminModel.phone!;
      return AlertDialog(
          title: Text("Modifier un admin", style: TextStyle(color: MesCouleur().couleurPrincipal,fontSize: 20),),
          content: SingleChildScrollView(
            child: Container(
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
               children: [
                Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    controller: nomControler,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFFEDB602)), // Couleur de la bordure lorsqu'elle est désactivée
                                        ),
                                        labelText: "Nom",
                                        prefixIcon: Icon(Icons.person_2_outlined,
                                            color: Color(0xFFEDB602)),
                                        border: OutlineInputBorder()),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return "Nom ne peut pas etre vide !";
                                      }
                                      if (text.length < 2) {
                                        return "Nom trop court !";
                                      }
                                      if (text.length > 60) {
                                        return "Nom trop long, Maximuin 30 !";
                                      }
                                    },
                                    // initialValue: adminModel.nom!,
                                    
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: prenomControler,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFFEDB602)), // Couleur de la bordure lorsqu'elle est désactivée
                                        ),
                                        labelText: "Prenom",
                                        prefixIcon: Icon(Icons.person_2_outlined,
                                            color: Color(0xFFEDB602)),
                                        border: OutlineInputBorder()),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return "Prenom ne peut pas etre vide !";
                                      }
                                      if (text.length < 2) {
                                        return "Prenom trop court !";
                                      }
                                      if (text.length > 60) {
                                        return "Prenom trop long, Maximuin 30 !";
                                      }
                                    },
                                    // pour afficher le donné
                                    // initialValue: adminModel.prenom!,
                                  ),
                                  SizedBox(height: 10),
                                  IntlPhoneField(
                                    controller: numControler,
                                    showCountryFlag: true,
                                    dropdownIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: MesCouleur().couleurPrincipal,
                                    ),
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFFEDB602)), // Couleur de la bordure lorsqu'elle est désactivée
                                        ),
                                        border: OutlineInputBorder()),
                                    initialCountryCode: 'ML',
                                    initialValue: adminModel.phone!,
                                  ),
                                  SizedBox(height: 5),
                                  TextFormField(
                                    controller: emailControler,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  0xFFEDB602)), // Couleur de la bordure lorsqu'elle est désactivée
                                        ),
                                        labelText: "Email",
                                        prefixIcon: Icon(Icons.email_outlined,
                                            color: Color(0xFFEDB602)),
                                        border: OutlineInputBorder()),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return "Email ne peut pas etre vide !";
                                      }
                                      if (EmailValidator.validate(text)) {
                                        return null;
                                      }
                                      if (text.length < 2) {
                                        return "Email trop court !";
                                      }
                                      if (text.length > 100) {
                                        return "Nom trop long, Maximuin 50 !";
                                      }
                                    },
                                    // initialValue: adminModel.email!,
                                  ),
                                  SizedBox(height: 10),
                                 
                                  SizedBox(
                                    height: 10,
                                  ),
                                 
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        width: 150,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                           Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red// Définir la couleur du bouton
                                        // Vous pouvez également personnaliser d'autres propriétés ici
                                      ),
                                          child: Text(
                                            'Annuler',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(255, 255, 255, 255),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 40,),
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        width: 150,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            adminModel.nom = nomControler.text;
                                            adminModel.prenom = prenomControler.text;
                                            adminModel.email = emailControler.text;
                                            adminModel.phone = numControler.text;
                                           await updateAdminId(adminModel);
                                           setState(() {
                                             Navigator.pop(context);
                                             Fluttertoast.showToast(msg: "Administrateur modifier");
                                           });
                                          },
                                          style: ElevatedButton.styleFrom(
                                        backgroundColor: MesCouleur().couleurPrincipal// Définir la couleur du bouton
                                        // Vous pouvez également personnaliser d'autres propriétés ici
                                      ),
                                          child: Text(
                                            'Modifier',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(255, 255, 255, 255),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ]),
                          ),
                  ], 
              ),
            ),
          ),
        );
    }
    );
  
  }

  // methode popup Confirmation de suppression
  Future showDeleteConfirme(BuildContext context, AdminModel adminModel) async{

    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text("Voulez-vous supprimer"),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            }, 
            child: Text(
              "Annuler",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold
              ),
            )),

            TextButton(
              onPressed: () async{
                await deleteAdminId(adminModel).then((value){
                  Fluttertoast.showToast(msg: " Suppression reussit");
                  setState(() {
                     Navigator.push(context, MaterialPageRoute(builder: (c)=> SideBarpage(userMap: {}))); 
                   });
                });
                
              //   if (adminModel!=null) {
              //     Fluttertoast.showToast(msg: " Suppression reussit");
              //     await deleteAdminId(adminModel).then((value) {
              //       Navigator.pop(context);
              //     setState(() {
                    
              //     });
              //     });
                  
              //   } 
              //  else{
              //   Fluttertoast.showToast(msg: " Suppression echoue");
              //  }
              //  userRef.child(firebaseAuth.currentUser!.uid).update({
                
              //  }).then((value) {
              //   numeroController.clear();
              //   Fluttertoast.showToast(msg:" modifié avec succè");
              //  }).catchError((errorMessage){
              //   Fluttertoast.showToast(msg: " modification echoue");
              //  });
              //  Navigator.pop(context);
            }, 
            child: Text(
              "Supprimer",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold
              ),
            )),
          ],
        );
      }
      );
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Container(
                // width: 1200,
                // height: 80,
                 child: Padding(
                   padding:  EdgeInsets.all(0.0),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      
                      SizedBox(height: 60,),
                       Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                "Liste des administrateurs",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: MesCouleur().couleurPrincipal),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await showAddAdmin(context);
                                },
                                child: Container(
                                    height: 30,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1),
                                        color: Colors.green,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Color.fromARGB(255, 187, 187, 187),
                                            spreadRadius: 0,
                                            blurRadius: 1,
                                          )
                                        ]),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10,),
                                        Text("AJOUTER", style: TextStyle(color: Colors.white,fontSize: 15))
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                      width: 1100,
                      child: Divider(height: 1, thickness: 1, color: MesCouleur().couleurPrincipal)),
                        ],
                       ),
                     ],
                   ),
                   
                 ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(right: 60),
              child: Container(
                
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ), 
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: listAdmin.length,
                  itemBuilder: (context, index){
                    return Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 60,top: 15,bottom: 15),
                          child: Container(
                              decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Colors.white,
                                  boxShadow:  [
                                BoxShadow(
                                  color: Color.fromARGB(255, 187, 187, 187),
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                )
                              ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15,top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    child: Text("${listAdmin [index].nom![0].toUpperCase()}.${listAdmin [index].prenom!.toUpperCase()[0]}", style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)
                                  ),
                                  SizedBox(height: 20,),
                                  
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.person, color: MesCouleur().couleurPrincipal,),
                                            SizedBox(width: 20,),
                                            Text("${listAdmin[index].prenom}", style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.person, color: MesCouleur().couleurPrincipal,),
                                            SizedBox(width: 20,),
                                            Text("${listAdmin[index].nom}", style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.phone_android, color: MesCouleur().couleurPrincipal,),
                                            SizedBox(width: 20,),
                                            Text("${listAdmin[index].phone}", style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                                                              SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.email, color: MesCouleur().couleurPrincipal,),
                                            SizedBox(width: 20,),
                                            Text("${listAdmin[index].email}", style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        SizedBox(height: 20,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                  await updateAdmin(context,listAdmin[index]);
                                                },
                                              child: Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                              borderRadius:
                                                        BorderRadius.circular(5),
                                                    color: Colors.blue,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromARGB(
                                                            255, 187, 187, 187),
                                                        spreadRadius: 0,
                                                        blurRadius: 1,
                                                      )
                                                    ]),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.edit, color: Colors.white,size: 20,),
                                                    SizedBox(width: 5,),
                                                    Text("Modifier",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                                    
                                                    
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 50,),
                                            GestureDetector(
                                              onTap: () async {
                                              await showDeleteConfirme(
                                                        context, listAdmin[index]);
                                                  },
                                              child: Container(
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                              borderRadius:
                                                        BorderRadius.circular(5),
                                                    color: Colors.red,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromARGB(
                                                            255, 187, 187, 187),
                                                        spreadRadius: 0,
                                                        blurRadius: 1,
                                                      )
                                                    ]),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.delete, color: Colors.white,size: 20,),
                                                    SizedBox(width: 5,),
                                                    Text("Supprimer",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                                   
                                                    
                                                  ],
                                                ),
                                              ),
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
                        ),
                      // child: Container(
                      //  height: 10,
                      //  width: 100,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: Colors.white,
                      //       boxShadow:  [
                      //         BoxShadow(
                      //           color: Color.fromARGB(255, 187, 187, 187),
                      //           spreadRadius: 2,
                      //           blurRadius: 1,
                      //         )
                      //       ]),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Padding(
                      //         padding:  EdgeInsets.only(left: 1, top: 10),
                      //         child: CircleAvatar(
                      //            // backgroundImage: AssetImage("assets/images/1.png"),
                      //             radius: 40,
                      //             backgroundColor: MesCouleur().couleurPrincipal,
                      //             child: Text("${listAdmin [index].nom![0].toUpperCase()}.${listAdmin [index].prenom!.toUpperCase()[0]}", style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)
                      //           ),
                      //       ),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           SizedBox(height: 25,),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               Icon(Icons.person),
                      //               SizedBox(width: 90,),
                      //               Text(
                      //                 "${listAdmin[index].prenom}", style: TextStyle(fontWeight: FontWeight.bold),
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(height: 5,),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               Icon(Icons.person),
                      //               SizedBox(width: 90,),
                      //               Text(
                      //                 "${listAdmin[index].nom}", style: TextStyle(fontWeight: FontWeight.bold),
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(height: 10,),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               Icon(Icons.phone_android),
                      //               SizedBox(width: 90,),
                      //               Text(
                      //                 "${listAdmin[index].phone}"
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(height: 10,),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               Icon(Icons.email),
                      //               SizedBox(width: 10,),
                      //               Text(
                      //                 "${listAdmin[index].email}"
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(height: 15,),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                                    
                      //               GestureDetector(
                      //                 onTap: () async {
                      //                   await updateAdmin(context,listAdmin[index]);
                      //                 },
                      //                 child: Container(
                      //                   height: 40,
                      //                   width: 40,
                      //                   decoration: BoxDecoration(
                      //                   borderRadius:
                      //                             BorderRadius.circular(5),
                      //                         color: Colors.blue,
                      //                         boxShadow: [
                      //                           BoxShadow(
                      //                             color: Color.fromARGB(
                      //                                 255, 187, 187, 187),
                      //                             spreadRadius: 0,
                      //                             blurRadius: 1,
                      //                           )
                      //                         ]),
                      //                   child: Icon(Icons.create, color: Colors.white,)),
                      //               ),
                      //               SizedBox(width: 20,),
                      //               GestureDetector(
                      //                 onTap: () async {
                      //                    await showDeleteConfirme(context, listAdmin[index]);
                      //                 },
                      //                 child: Container(
                      //                   height: 40,
                      //                   width: 40,
                      //                   decoration: BoxDecoration(
                      //                   borderRadius:
                      //                             BorderRadius.circular(5),
                      //                         color: Colors.red,
                      //                         boxShadow: [
                      //                           BoxShadow(
                      //                             color: Color.fromARGB(
                      //                                 255, 187, 187, 187),
                      //                             spreadRadius: 0,
                      //                             blurRadius: 1,
                      //                           )
                      //                         ]),
                      //                   child: Icon(Icons.delete, color: Colors.white,)),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    );
                   } ,
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



class LikeListTile extends StatelessWidget {
  const LikeListTile({
    Key? key,
    required this.title,
    required this.likes,
    required this.subtitle,
    required this.imgUrl,
    this.color = Colors.grey
  }) : super(key: key);
  final String title;
  final String likes;
  final String subtitle;
  final Color color;
  final String imgUrl;
  @override
  
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Container(
        width: 50,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                    image: NetworkImage(
                        imgUrl,))),
          ),
        ),
      ),
      title: Text(title),
      subtitle: Row(
        children: [
          Icon(Icons.favorite, color: Colors.orange, size:20),
          SizedBox(width: 3,),
          Text(likes),
          Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(width: 4, height: 4),
              )),
          Text(subtitle)
        ],
      ),
      trailing: LikeButton(onPressed: () {}, color: Colors.orange) ,
    );
  }
}
class LikeButton extends StatefulWidget {
  const LikeButton(
      {Key? key, required this.onPressed, this.color = Colors.black12})
      : super(key: key);
  final Function onPressed;
  final Color color;
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
      icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
          color: widget.color),
      onPressed: () {
        setState(() {
          isLiked = !isLiked;
        });
        widget.onPressed();
      },
    ));
  }
}