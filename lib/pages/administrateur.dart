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
      body: Text("Administrateur"),
    );
  }
}