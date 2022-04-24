import 'dart:typed_data';

import 'package:instgramclone/services/storage/firebase_storage.dart';
import 'package:instgramclone/services/storage/image_storage.dart';

class StorageService implements Storage {
  final Storage storage;
  StorageService(this.storage);

  factory StorageService.firebase() => StorageService(FirebaseCloudStorage());

  @override
  Future<String> uploadImage(
          String id, Uint8List? file, String childName, bool isPost) =>
      storage.uploadImage(
        id,
        file,
        childName,
        isPost,
      );

  @override
  Future<void> uploadPost(
    String uid,
    String description,
    Uint8List file,
    String username,
    String profImage,
  ) =>
      storage.uploadPost(
        uid,
        description,
        file,
        username,
        profImage,
      );
}
