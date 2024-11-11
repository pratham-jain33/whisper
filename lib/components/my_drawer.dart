import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisper/services/auth/auth_service.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    // Get auth service
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header and navigation items
          Column(
            children: [
              // Logo
              DrawerHeader(
                child: Center(
                  child: Image.asset(
                    'images/icon.png', // Replace with the path to your image
                    height: 100.0, // Adjust as needed
                    width: 100.0, // Adjust as needed
                  ),
                ),
              ),
              // Home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(Icons.home_rounded),
                  onTap: () {
                    // Pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),
              // Settings list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(CupertinoIcons.settings),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to settings page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // Logout list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: const Text(
                "L O G O U T",
                style: TextStyle(color: Colors.red),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
