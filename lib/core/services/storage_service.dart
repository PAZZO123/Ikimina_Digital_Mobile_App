import 'dart:io';

import 'package:image_picker/image_picker.dart';

// StorageService — image picking only (Firebase Storage removed for compatibility)
// To re-enable cloud uploads, add firebase_storage back to pubspec.yaml

class StorageService {
  static final _picker = ImagePicker();

  /// Pick an image from gallery or camera
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

  /// Upload profile picture — returns local file path (no cloud upload)
  static Future<String> uploadProfilePicture(File file, String userId) async {
    // Cloud upload disabled — return local path
    return file.path;
  }

  /// Upload group cover image — returns local file path
  static Future<String> uploadGroupImage(File file, String groupId) async {
    return file.path;
  }

  /// Upload contribution receipt — returns local file path
  static Future<String> uploadReceipt(File file, String contributionId) async {
    return file.path;
  }

  /// Delete a file (no-op without Firebase Storage)
  static Future<void> deleteFile(String downloadUrl) async {
    // No-op — cloud storage not enabled
  }
}