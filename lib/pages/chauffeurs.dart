import 'package:flutter/material.dart';

class Chauffeurs extends StatefulWidget {
  const Chauffeurs({super.key});

  @override
  State<Chauffeurs> createState() => _ChauffeursState();
}

class _ChauffeursState extends State<Chauffeurs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Chauffeur"),
    );
  }
}