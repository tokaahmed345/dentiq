import 'package:bloc/bloc.dart';
import 'package:dentiq/features/auth/data/repos/forgot_password_repo/forgot_password.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_state.dart';


class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepo repo;

  ForgotPasswordCubit(this.repo) : super(ForgotPasswordInitial());

  Future<void> sendLink(String email) async {
    emit(ForgotPasswordLoading());

    final result = await repo.sendResetLink(email);

    result.fold(
      (failure) => emit(ForgotPasswordFailure(errorMessage:  failure.message)),
      (_) => emit(ForgotPasswordSuccess()),
    );
  }
}
