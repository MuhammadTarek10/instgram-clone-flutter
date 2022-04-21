import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:instgramclone/exceptions/image_excetptions.dart';
import 'package:instgramclone/services/storage/image_storage.dart';

class FirebaseCloudStorage implements Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<String> uploadImage(
      String id, Uint8List? file, String childName, bool isPost) async {
    try {
      Reference ref = _storage.ref().child(childName).child(id);
      UploadTask uploadTask = ref.putData(file!);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw CouldnotGetImageException();
    }
  }
}
