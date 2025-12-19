import 'package:bloc/bloc.dart';
import 'package:dentiq/features/auth/data/model/sign_up_model.dart';
import 'package:dentiq/features/auth/data/repos/sign_up_repo/sign_up_repo.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo signUpRepo;
  
  SignUpCubit(this.signUpRepo) : super(SignUpInitial());
  Future<void>signUp({ required String name,
    required String email,
    required String password,
    required String phone,
    required String gender,})async{

final user = await signUpRepo.register(name: name, email: email, password: password, phone: phone, gender: gender);
user.fold((failure)=>emit(SignUpFailure(errorMessage: failure.message)), (user)=>emit(SignUpSuccess(userModel: user)));

    }
}
