import 'package:bloc/bloc.dart';
import 'package:dentiq/features/auth/data/model/log_in_model.dart';
import 'package:dentiq/features/auth/data/repos/log_in_repo/log_in_repo.dart';
import 'package:equatable/equatable.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit(this.logInRepo) : super(LogInInitial());
    final LogInRepo logInRepo;

    Future<void>logIn({ 
    required String email,
    required String password,
})async{
       emit(LogInLoading());

final user = await logInRepo.login(email: email, password: password,);
user.fold((failure)=>emit(LogInFailure(errorMessage: failure.message)), (user)=>emit(LogInSuccess(logIn: user)));

    }
}
