part of 'log_in_cubit.dart';

sealed class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object> get props => [];
}

final class LogInInitial extends LogInState {}
final class LogInLoading extends LogInState {}
final class LogInSuccess extends LogInState {
  final LogInModel logIn;

  const LogInSuccess({required this.logIn});

}
final class LogInFailure extends LogInState {
  final String errorMessage;

  const LogInFailure({required this.errorMessage});

}
