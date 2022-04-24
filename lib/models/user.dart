import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instgramclone/constants/database_columns.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
  });

  User.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : username = snapshot.data()[usernameColumnFieldName],
        uid = snapshot.data()[userIdColumnFieldName],
        photoUrl = snapshot.data()[photoUrlColumnFieldName],
        email = snapshot.data()[emailColumnFieldName],
        bio = snapshot.data()[bioColumnFieldName],
        followers = snapshot.data()[followeringColumnFieldName],
        following = snapshot.data()[followeringColumnFieldName];

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot[usernameColumnFieldName],
      uid: snapshot[userIdColumnFieldName],
      photoUrl: snapshot[photoUrlColumnFieldName],
      email: snapshot[emailColumnFieldName],
      bio: snapshot[bioColumnFieldName],
      followers: snapshot[followeringColumnFieldName],
      following:  snapshot[followeringColumnFieldName],
    );
  }
}
