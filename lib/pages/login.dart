import 'package:dashboard1/config/configurationCouleur.dart';
import 'package:dashboard1/global/global.dart';
import 'package:dashboard1/pages/passwordForget.dart';
import 'package:dashboard1/side_bar.dart/side_bar_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final auth = await firebaseAuth
          .signInWithEmailAndPassword(
              email: emailControler.text.trim(),
              password: passControler.text.trim());

        DatabaseReference userRef =
              FirebaseDatabase.instance.ref().child("users");

        final value = await userRef.child(firebaseAuth.currentUser!.uid).once();
        final snap = value.snapshot;
        if (snap.value != null) {
          currentUser = auth.user;
          print(snap.value);
          print("-----------------------------------------------------------------------");
          print(currentUser);
          print("-----------------------------------------------------------------------");
          await Fluttertoast.showToast(msg: "Connexion reussie");
          Navigator.push(context, MaterialPageRoute(builder: (index) => SideBarpage(userMap: snap.value as Map<String,dynamic>,)));
        }
        else{
          await Fluttertoast.showToast(msg: "Vous n'avez pas de compte !");
          firebaseAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (index) => Connexion()));
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Connexion echoué");
        throw Exception(e.toString());
      }
    }
    else{
      Fluttertoast.showToast(msg: "Remplissez les champs vides");
    }
  }

  
  final emailControler = TextEditingController();
  final passControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passToggle = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Colors.white,
        //   title: Center(
        //     child: Text(
        //       "Connexion",
        //       style: TextStyle(
        //         color: MesCouleur().couleurPrincipal,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: MesCouleur().couleurPrincipal,
            ),
            child: Center(
              child: Container(
                width: 400,
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(30),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Text(
                            "Connexion",
                            style: TextStyle(
                              color: MesCouleur().couleurPrincipal,
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                            ),
                          ),
                              SizedBox(height: 50,),
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
                                          // return null;
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
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        width: 350,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () async{
                                            await _submit();
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
                                      ),
                
                                      SizedBox(height: 20,),
                                      GestureDetector(
                                    onTap: () {
                                      // Redirection vers la page d'inscription
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PasswordForget() ),
                                      );
                                    },
                                    child: const Text(
                                      "Mot de passe oublié",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFEDB602),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                    ]),
                              ),
                
                              SizedBox(height: 30),
                            Image.asset("assets/images/ou.png",),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset("assets/images/google.png"),
                                Image.asset("assets/images/facebook.png"),
                              ],
                            ),
                
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                     SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
