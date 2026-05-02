import 'package:bloc/bloc.dart';
import 'package:dentiq/features/chat/data/model/chat_model.dart';
import 'package:dentiq/features/chat/data/repos/chat_repo.dart';
import 'package:equatable/equatable.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepo) : super(ChatInitial());
     final ChatRepo chatRepo;
 
Future<void> fetchMessage({required String message}) async {
  emit(ChatLoading());

  final response = await chatRepo.sendMessage(message: message);

  response.fold(
    (failure) {
      emit(ChatFailure(errorMessage: failure.errMessage));
    },
    (successChatModel) {
      emit(ChatSuccess(message: successChatModel));
    },
  );
}

}
