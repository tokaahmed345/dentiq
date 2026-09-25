import 'dart:io';

import 'package:dentiq/core/utils/sharedprefrence.dart';
import 'package:dentiq/features/profile/data/repos/profile_header_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileHeaderRepoImpl extends ProfileHeaderRepo {
  final SupabaseClient supabase;
  final FirebaseAuth firebaseAuth;
  final SharedPrefs sharedPrefs;

  ProfileHeaderRepoImpl({
    required this.supabase,
    required this.firebaseAuth,
    required this.sharedPrefs,
  });
@override
Future<String?> getProfileImage(String userId) async {
  final fileName = 'profile_$userId.png';

  try {
    await supabase.storage
        .from('Profile_image')
        .download(fileName);

    return '${supabase.storage.from('Profile_image').getPublicUrl(fileName)}'
        '?t=${DateTime.now().millisecondsSinceEpoch}';
  } catch (_) {
    return null;
  }
}

  @override
  Future<String?> uploadProfileImage(String userId, File file) async {
    final fileName = 'profile_$userId.png';
    await supabase.storage.from('Profile_image').uploadBinary(
          fileName,
          await file.readAsBytes(),
          fileOptions: const FileOptions(upsert: true),
        );
    return '${supabase.storage.from('Profile_image').getPublicUrl(fileName)}?t=${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
Future<String?> getUserName() async {
  final name = await sharedPrefs.getUserName();
  return name ?? 'User';
}

}
