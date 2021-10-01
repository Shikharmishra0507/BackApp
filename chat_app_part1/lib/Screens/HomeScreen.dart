import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  @override
  static const String route="/homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex=0;
  void navigationBarTap(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text("My Chat App"),
            backgroundColor: Colors.pink,
        ),
        body:Container(
          child:Text("something"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.call),label:'call'),
            BottomNavigationBarItem(icon: Icon(Icons.chat),label:'chat'),
            BottomNavigationBarItem(icon:Icon(Icons.contacts),label: 'contacts'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label:'settings'),
          ],
          onTap: navigationBarTap,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black26,
        )


    );
  }
}
