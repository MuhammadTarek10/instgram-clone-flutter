import 'dart:typed_data';
import 'package:flutter/material.dart';

@immutable
abstract class Storage {
  Future<String> uploadImage(
    String id,
    Uint8List? file,
    String childName,
    bool isPost,
  );

  Future<void> uploadPost(
    String uid,
    String description,
    Uint8List file,
    String username,
    String profImage,
  );
}
