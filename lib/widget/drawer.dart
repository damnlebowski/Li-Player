// ignore_for_file: prefer_const_constructors

import 'package:fi_player/screens/screen_settings/screen_settings.dart';
import 'package:flutter/material.dart';
import '../screens/screen_help/screen_help.dart';

bool isDarkMode = false;
Color? mainBGColor = Colors.purple[50];
Color? allTextColor = Colors.black;
Color? bottomNavColor = Colors.white;

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
        backgroundColor: mainBGColor,
        elevation: 5,
        children: [
          Container(
            height: 70,
            color: Colors.purple,
          ),
          SizedBox(
            height: 200,
            child: Image.asset('assets/FI_PLAYER.png'),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.dark_mode_outlined, color: Colors.purple),
            title: Text(
              'Dark Theme',
              style: TextStyle(color: allTextColor),
            ),
            trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    if (isDarkMode == true) {
                      isDarkMode = false;
                      mainBGColor = Colors.purple[50];
                      allTextColor = Colors.black;
                      bottomNavColor = Colors.white;
                    } else {
                      isDarkMode = true;
                      mainBGColor = Color.fromARGB(255, 43, 7, 48);
                      allTextColor = Colors.white;
                      bottomNavColor = Colors.black;
                    }
                  });
                }),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StettingsScreen(),
            )),
            leading: Icon(Icons.settings_applications, color: Colors.purple),
            title: Text(
              'Settings',
              style: TextStyle(color: allTextColor),
            ),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HelpScreen(),
            )),
            leading: Icon(Icons.help_center_outlined, color: Colors.purple),
            title: Text(
              'Help',
              style: TextStyle(color: allTextColor),
            ),
          ),
        ]);
  }
}
