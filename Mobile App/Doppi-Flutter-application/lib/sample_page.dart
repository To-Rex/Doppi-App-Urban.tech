import 'package:doppi/fragmentsTab/analytics_page.dart';
import 'package:doppi/fragmentsTab/produckt_page.dart';
import 'package:doppi/fragmentsTab/settings_page.dart';
import 'package:doppi/fragmentsTab/tables_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {

  int _selectedIndex = 0;
  late SharedPreferences prefs;

  Future<void> logout() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return  const MyHomePage(title: '',);
    }));
  }

  static const List<Widget> _widgetOptions = <Widget>[
    ProductPage(),
    TablesPage(),
    AnalyticsPage(),
    SettingsPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        backgroundColor: const Color.fromRGBO(33, 158, 188, 10),
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/bottab1.svg',
              height: 25,
              width: 25,
            ),
            //selleceted icon color is white
            activeIcon: SvgPicture.asset(
              'assets/svgs/bottab1.svg',
              height: 25,
              width: 25,
              color: Colors.white,
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/bottab2.svg',
              height: 25,
              width: 25,
            ),
            //selleceted icon color is white
            activeIcon: SvgPicture.asset(
              'assets/svgs/bottab2.svg',
              height: 25,
              width: 25,
              color: Colors.white,
            ),
            label: 'Tables',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/bottab3.svg',
              height: 25,
              width: 25,
            ),
            //selleceted icon color is white
            activeIcon: SvgPicture.asset(
              'assets/svgs/bottab3.svg',
              height: 25,
              width: 25,
              color: Colors.white,
            ),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/bottab4.svg',
              height: 25,
              width: 25,
            ),
            //selleceted icon color is white
            activeIcon: SvgPicture.asset(
              'assets/svgs/bottab4.svg',
              height: 25,
              width: 25,
              color: Colors.white,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        onTap: _onItemTapped,
      ),
    );
  }
}
