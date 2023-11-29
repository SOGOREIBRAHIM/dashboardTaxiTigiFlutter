import 'package:dashboard1/firebase_options.dart';
import 'package:dashboard1/pages/login.dart';
import 'package:dashboard1/side_bar.dart/side_bar_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Tigui',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Colors.amber,),
        splashColor: Colors.amber,
        primarySwatch: Colors.amber,
        fontFamily: "Poppins"
      ),
      debugShowCheckedModeBanner: false,
      home: Connexion(),
      // home: SideBarpage(),
    );
  }
}





