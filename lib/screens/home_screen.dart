import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/user_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App - Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No users registered yet.\nCreate more accounts to test.',
                textAlign: TextAlign.center,
              ),
            );
          }

          final otherUsers = snapshot.data!.docs.where(
            (doc) => doc.id != currentUserId,
          );

          if (otherUsers.isEmpty) {
            return const Center(child: Text('No other users available'));
          }

          return ListView.builder(
            itemCount: otherUsers.length,
            itemBuilder: (context, index) {
              final doc = otherUsers.elementAt(index);
              final data = doc.data() as Map<String, dynamic>;

              return UserTile(
                userId: doc.id,
                email: data['email'] ?? 'Unknown',
                photoUrl: data['photoUrl'],
                isOnline: data['isOnline'] ?? false,
              );
            },
          );
        },
      ),
    );
  }
}