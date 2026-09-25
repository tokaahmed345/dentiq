part of 'log_out_cubit.dart';

sealed class LogOutState extends Equatable {
  const LogOutState();

  @override
  List<Object> get props => [];
}

final class LogOutInitial extends LogOutState {}
final class LogOutLoading extends LogOutState {}
final class LogOutSuccess extends LogOutState {}
final class LogOutFailure extends LogOutState {
  final String errorMessage;
  const LogOutFailure({required this.errorMessage});
}
