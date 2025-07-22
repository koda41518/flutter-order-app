class UserModel {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        uid: data['uid'] as String,
        email: data['email'] as String?,
        displayName: data['displayName'] as String?,
        photoUrl: data['photoUrl'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'email': email,
        'displayName': displayName,
        'photoUrl': photoUrl,
      };
}