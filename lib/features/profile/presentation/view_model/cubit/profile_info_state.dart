part of 'profile_info_cubit.dart';

sealed class ProfileInfoState extends Equatable {
  const ProfileInfoState();

  @override
  List<Object> get props => [];
}

final class ProfileInfoInitial extends ProfileInfoState {}

final class ProfileInfoLoading extends ProfileInfoState {}
final class ProfileInfoGetSuccess extends ProfileInfoState {}    
final class ProfileInfoUpdateSuccess extends ProfileInfoState {} 
final class ProfileInfoFailure extends ProfileInfoState {
  final String errorMessage;
  const ProfileInfoFailure({required this.errorMessage});
}
final class ProfileInfoUpdateFailure extends ProfileInfoState {
  final String errorMessage;
  const ProfileInfoUpdateFailure ({required this.errorMessage});
}
