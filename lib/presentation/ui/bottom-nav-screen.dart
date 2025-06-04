import 'package:flutter/material.dart';
import 'package:reachaid/user-type.dart';
import 'rescuer-screen.dart';
import 'user-home/emergency-screen.dart';

class BottomNavScreen extends StatefulWidget {
  final UserType userType;

  const BottomNavScreen({super.key, required this.userType});

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState(userType);
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;
  final UserType userType;

  List<Widget> get _screens {
    return <Widget>[
      userType == UserType.Rescuer ? const RescuerScreen() : EmergencyScreen(),
      const Center(
          child: Text('Search Screen', style: TextStyle(fontSize: 24))),
      const Center(
          child: Text('Notification Screen', style: TextStyle(fontSize: 24))),
      const Center(
          child: Text('Messages Screen', style: TextStyle(fontSize: 24))),
    ];
  }

  _BottomNavScreenState(this.userType);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'بحث',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'الاشعارات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'الرسائل',
          ),
        ],
      ),
    );
  }
}
