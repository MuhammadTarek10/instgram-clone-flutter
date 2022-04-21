import 'dart:typed_data';
import 'package:flutter/material.dart';


@immutable
abstract class Storage {
  Future<String> uploadImage(
      String id, Uint8List? file, String childName, bool isPost);
}
