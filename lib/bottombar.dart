import 'package:apicalling/apiclling.dart';
import 'package:flutter/material.dart';

class Bottombar extends StatefulWidget {
   const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _selectedIndex = 0;
  static  final List<Widget> _widgetOptions = <Widget>[
      const TeslaNewsScreen(),
    const Text('Search Page', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    const Text('Profile Page', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items:  const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label:"Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label:"serch",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
             label: 'profile',
            ),
          ],
          currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          iconSize: 20,
          onTap: _onItemTapped,
          elevation: 5,

      ),
    );
  }
}




