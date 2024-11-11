import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whisper/services/chat/chat_service.dart';
import 'package:whisper/themes/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageId;
  final String userId;

  const ChatBubble(
      {super.key,
      required this.message,
      required this.isCurrentUser,
      required this.messageId,
      required this.userId});

  //show options
  void _showOptions(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              //report  message button
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text(
                  'Report',
                  style: TextStyle(fontFamily: 'SFPro'),
                ),
                onTap: () {
                  Navigator.pop(context);
                  reportMessage(context, messageId, userId);
                },
              ),

              //block user button
              ListTile(
                leading: const Icon(Icons.block),
                title: const Text(
                  'Block User',
                  style: TextStyle(fontFamily: 'SFPro'),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _blockUser(context, userId);
                },
              ),
              //cancel button
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text(
                  'Cancel',
                  style: TextStyle(fontFamily: 'SFPro'),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  //report user
  void reportMessage(BuildContext context, String userId, String messageId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Report Message"),
        content: const Text("Are you sure you want to report this message?"),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          //report button
          TextButton(
            onPressed: () => {
              ChatService().reportUser(messageId, userId),
              Navigator.pop(context),
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                "Message Reported!",
                style: TextStyle(fontFamily: 'SFPro'),
              )))
            },
            child: const Text(
              "Report",
              style: TextStyle(fontFamily: 'SFPro'),
            ),
          ),
        ],
      ),
    );
  }

  //block user
  void _blockUser(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Block User"),
        content: const Text("Are you sure you want to block this user?"),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          //block button
          TextButton(
            onPressed: () => {
              ChatService().blockUser(userId),
              Navigator.pop(context),
              Navigator.pop(context),
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                "User Blocked!",
                style: TextStyle(fontFamily: 'SFPro'),
              )))
            },
            child: const Text(
              "Block",
              style: TextStyle(fontFamily: 'SFPro'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //light vs dark mode for correct bubble colors
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return GestureDetector(
      onLongPress: () {
        if (!isCurrentUser) {
          //show options
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isCurrentUser
              ? isDarkMode
                  ? Colors.green.shade600
                  : Colors.green.shade500
              : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
        child: Text(
          message,
          style: TextStyle(
            color: isCurrentUser
                ? Colors.white
                : (isDarkMode ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
