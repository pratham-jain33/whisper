import 'package:flutter/material.dart';
import 'package:whisper/components/my_drawer.dart';
import 'package:whisper/pages/chat_page.dart';
import 'package:whisper/services/auth/auth_service.dart';
import 'package:whisper/services/chat/chat_service.dart';
import '../components/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Chat and auth service instances
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "U S E R S",
          style: TextStyle(fontFamily: 'SFPro'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade600,
        elevation: 0.0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  // Build a list of users except for the current logged-in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStreamExcludingBlocked(),
      builder: (context, snapshot) {
        // Error handling
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Error loading users!",
              style: TextStyle(fontFamily: 'SFPro'),
            ),
          );
        }

        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(
              "Loading...",
              style: TextStyle(fontFamily: 'SFPro'),
            ),
          );
        }

        // Check if snapshot has data
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text(
              "No users found.",
              style: TextStyle(fontFamily: 'SFPro'),
            ),
          );
        }

        // Return list of users
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // Build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // Ensure that email and uid are not null
    final email = userData["email"] as String?;
    final uid = userData["uid"] as String?;

    if (email != null &&
        uid != null &&
        email != _authService.getCurrentUser()) {
      return UserTile(
        text: email,
        onTap: () {
          // Navigate to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: email,
                receiverID: uid,
              ),
            ),
          );
        },
      );
    } else {
      return Container(); // Return an empty container if the user is the current user or if data is null
    }
  }
}
