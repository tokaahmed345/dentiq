import 'dart:io';

abstract class ProfileHeaderRepo {
  Future<String?> getProfileImage(String userId);
  Future<String?> uploadProfileImage(String userId, File file);
  Future<String?> getUserName();
}