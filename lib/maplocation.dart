import 'package:flutter/material.dart';

class Maplocation extends StatefulWidget {
  const Maplocation({super.key});

  @override
  State<Maplocation> createState() => _MaplocationState();
}

class _MaplocationState extends State<Maplocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("MapLocation",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
