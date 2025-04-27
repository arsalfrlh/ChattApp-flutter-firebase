import 'package:chatapp/pages/setting_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  AuthService authService = AuthService();
  void logout(){
    authService.logout();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Anda telah logout"), backgroundColor: Colors.orange,));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 211, 203, 203),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 80,
                ),
              )),
              Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("H O M E"),
                    leading: Icon(Icons.home),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("S E T T I N G"),
                    leading: Icon(Icons.settings),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingPage()));
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("L O G O U T"),
                    leading: Icon(Icons.logout),
                    onTap: logout,
                  ))
            ],
          )
        ],
      ),
    );;
  }
}