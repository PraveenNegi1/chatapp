import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';

class UserTile extends StatelessWidget {
  final String userId;
  final String email;
  final String? photoUrl;
  final bool isOnline;

  const UserTile({
    super.key,
    required this.userId,
    required this.email,
    this.photoUrl,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
        child: photoUrl == null ? const Icon(Icons.person) : null,
      ),
      title: Text(email),
      subtitle: Text(isOnline ? 'Online' : 'Offline'),
      trailing: isOnline
          ? const Icon(Icons.circle, color: Colors.green, size: 12)
          : null,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              receiverId: userId,
              receiverEmail: email,
            ),
          ),
        );
      },
    );
  }
}