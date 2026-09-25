import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dentiq/features/profile/data/repos/profile_header_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'profile_image_state.dart';

class ProfileHeaderCubit extends Cubit<ProfileHeaderState> {
  final ProfileHeaderRepo repo;
  final FirebaseAuth firebaseAuth;

  ProfileHeaderCubit({required this.repo, required this.firebaseAuth})
      : super(const ProfileHeaderState()) {
    loadHeader();
  }

  Future<void> loadHeader() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return;

    final imageUrl = await repo.getProfileImage(user.uid);
    final userName = await repo.getUserName();

    emit(state.copyWith(userName: userName, imageUrl: imageUrl));
  }

  Future<void> pickAndUploadImage(File file) async {
    final user = firebaseAuth.currentUser;
    if (user == null) return;

    emit(state.copyWith(localImage: file));

    final newUrl = await repo.uploadProfileImage(user.uid, file);
    emit(state.copyWith(imageUrl: newUrl));
  }
}
