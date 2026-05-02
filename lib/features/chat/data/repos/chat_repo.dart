import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/failure/server_failure.dart';
import 'package:dentiq/features/chat/data/model/chat_model.dart';

abstract class ChatRepo {
  Future<Either<ServerFail,ChatModel>>sendMessage({required String message});
}