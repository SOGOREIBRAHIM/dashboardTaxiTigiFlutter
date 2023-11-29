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
      body: Text("Dashboard"),
    );
  }
}