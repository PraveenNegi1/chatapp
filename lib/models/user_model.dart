class AppUser {
  final String uid;
  final String email;
  final String? photoUrl;
  final bool isOnline;

  AppUser({
    required this.uid,
    required this.email,
    this.photoUrl,
    required this.isOnline,
  });

  factory AppUser.fromMap(Map<String, dynamic> data, String id) {
    return AppUser(
      uid: id,
      email: data['email'],
      photoUrl: data['photoUrl'],
      isOnline: data['isOnline'] ?? false,
    );
  }
}