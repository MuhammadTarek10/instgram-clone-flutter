import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:instgramclone/exceptions/image_excetptions.dart';
import 'package:instgramclone/models/post.dart';
import 'package:instgramclone/services/storage/image_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseCloudStorage implements Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<String> uploadImage(
      String id, Uint8List? file, String childName, bool isPost) async {
    try {
      Reference ref = _storage.ref().child(childName).child(id);

      if (isPost) {
        String id = const Uuid().v1();
        ref = ref.child(id);
      }
      UploadTask uploadTask = ref.putData(file!);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw CouldnotGetImageException();
    }
  }

  @override
  Future<void> uploadPost(
    String uid,
    String description,
    Uint8List file,
    String username,
    String profImage,
  ) async {
    try {
      final photoUrl = await uploadImage(
        uid,
        file,
        'posts',
        true,
      );

      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);

      _firestore.collection('posts').doc(postId).set(post.toJson());
    } on Exception {
      rethrow;
    }
  }
}
