import 'package:bloc/bloc.dart';
import 'package:dentiq/features/profile/data/repos/profile_info/profile_info_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit(this.profileRepo) : super(ProfileInfoInitial());

  final ProfileInfoRepo profileRepo;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  Future<void> getProfileData() async {
    emit(ProfileInfoLoading());

    final result = await profileRepo.getProfileData();

    result.fold(
      (failure) => emit(ProfileInfoFailure(errorMessage:  failure.message)),
      (user) {
        nameController.text = user.name;
        phoneController.text = user.phone;
        emailController.text = user.email;
        emit(ProfileInfoGetSuccess());
      },
    );
  }
   @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    return super.close();
  }

  

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String email,
    String? password,
    required String oldPassword, 
  }) async {
    emit(ProfileInfoLoading());

    final result = await profileRepo.updateProfile(
      name: name,
      phone: phone,
      email: email,
      password: password,
      oldPassword: oldPassword,
    );

    result.fold(
      (failure) => emit(ProfileInfoUpdateFailure(errorMessage: failure.message)),
      (_) => emit(ProfileInfoUpdateSuccess()),
    );
  }
}

