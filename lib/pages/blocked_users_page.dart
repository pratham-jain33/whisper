import 'package:flutter/material.dart';
import 'package:whisper/components/user_tile.dart';
import 'package:whisper/services/auth/auth_service.dart';
import 'package:whisper/services/chat/chat_service.dart';

class BlockedUsersPage extends StatelessWidget {
  BlockedUsersPage({super.key});

  // Chat and auth service
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  // Show confirm unblock box
  void _showUnblockBox(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Unblock User"),
        content: const Text("Are you sure you want to unblock this user?"),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          // Unblock button
          TextButton(
            onPressed: () {
              chatService.unblockUser(userId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User unblocked!")),
              );
            },
            child: const Text("Unblock"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get current user's id
    String userId = authService.getCurrentUser()!.uid;

    // UI
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Blocked Users",
          style: TextStyle(fontFamily: 'SFPro'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade600,
        elevation: 0.0,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatService.getBlockedUsersStream(userId),
        builder: (context, snapshot) {
          // Errors
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error! Loading.."),
            );
          }

          // Loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final blockedUsers = snapshot.data ?? [];

          // No users
          if (blockedUsers.isEmpty) {
            return const Center(
              child: Text("No blocked users"),
            );
          }

          // Load complete
          return ListView.builder(
            itemCount: blockedUsers.length,
            itemBuilder: (context, index) {
              final user = blockedUsers[index];
              return UserTile(
                text: user["email"],
                onTap: () => _showUnblockBox(context, user['uid']),
              );
            },
          );
        },
      ),
    );
  }
}
