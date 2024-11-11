import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/pages/blocked_users_page.dart';
import 'package:whisper/themes/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "S E T T I N G S",
          style: TextStyle(fontFamily: 'SFPro'),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade600,
        elevation: 0.0,
        centerTitle: true,
      ),
      body:
          //dark mode
          Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.all(25),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //dark mode
                Text(
                  "Dark Mode",
                  style: TextStyle(
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),

                //switch toggle
                CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkMode,
                  onChanged: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(),
                ),
              ],
            ),
          ),

          //blocked users
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.all(25),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //title
                Text(
                  "Blocked Users",
                  style: TextStyle(
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),

                //button to go to blocked user page
                IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlockedUsersPage())),
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
