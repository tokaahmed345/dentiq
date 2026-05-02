import 'package:bloc/bloc.dart';
import 'package:dentiq/features/auth/data/repos/log_out_repo/logout_repo.dart';
import 'package:equatable/equatable.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit(this.logoutRepo) : super(LogOutInitial());
  final LogoutRepo logoutRepo;
  Future <void> logOut()async{
emit(LogOutLoading());
final res= await logoutRepo.logout();
res.fold((fail)=>emit(LogOutFailure(errorMessage: fail.message)), (success)=>emit(LogOutSuccess()));
  }
}
