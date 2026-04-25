import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  static final _picker = ImagePicker();
  static final _storage = FirebaseStorage.instance;

  /// Show gallery/camera picker and return the selected file.
  static Future<File?> pickImage({
    ImageSource source = ImageSource.gallery,
    int maxWidthPx = 800,
    int quality = 85,
  }) async {
    final picked = await _picker.pickImage(
      source: source,
      maxWidth: maxWidthPx.toDouble(),
      imageQuality: quality,
    );
    if (picked == null) return null;
    return File(picked.path);
  }

  /// Upload profile picture to Firebase Storage and return the download URL.
  static Future<String> uploadProfilePicture(File file, String userId) async {
    final ref = _storage
        .ref()
        .child('users')
        .child(userId)
        .child('profile.jpg');

    final task = await ref.putFile(
      file,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    return await task.ref.getDownloadURL();
  }

  /// Upload group cover image — returns download URL.
  static Future<String> uploadGroupImage(File file, String groupId) async {
    final ref = _storage
        .ref()
        .child('group_images')
        .child('$groupId.jpg');

    final task = await ref.putFile(
      file,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    return await task.ref.getDownloadURL();
  }

  /// Upload contribution receipt — returns download URL.
  static Future<String> uploadReceipt(File file, String contributionId) async {
    final ref = _storage
        .ref()
        .child('receipts')
        .child('$contributionId.jpg');

    final task = await ref.putFile(
      file,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    return await task.ref.getDownloadURL();
  }

  /// Delete a file from Firebase Storage by its download URL.
  static Future<void> deleteFile(String downloadUrl) async {
    try {
      final ref = _storage.refFromURL(downloadUrl);
      await ref.delete();
    } catch (_) {
      // Ignore — file may already be deleted or URL invalid
    }
  }
}
