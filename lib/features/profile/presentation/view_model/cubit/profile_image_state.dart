part of 'profile_image_cubit.dart';

class ProfileHeaderState extends Equatable {
  final String? imageUrl;
  final String? userName;
  final File? localImage;

  const ProfileHeaderState({this.imageUrl, this.userName, this.localImage});

  ProfileHeaderState copyWith({
    String? imageUrl,
    String? userName,
    File? localImage,
  }) {
    return ProfileHeaderState(
      imageUrl: imageUrl ?? this.imageUrl,
      userName: userName ?? this.userName,
      localImage: localImage ?? this.localImage,
    );
  }

  @override
  List<Object?> get props => [imageUrl, userName, localImage];
}
