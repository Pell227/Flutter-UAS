class UserModel {
  final String uid;
  final String name;
  final String bio;
  final String photoUrl;

  const UserModel({
    required this.uid,
    required this.name,
    this.bio = '',
    this.photoUrl = '',
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'bio': bio,
    'photoUrl': photoUrl,
  };
}
