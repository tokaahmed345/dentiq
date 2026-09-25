import 'package:dartz/dartz.dart';
import 'package:dentiq/core/utils/constant/endpoints.dart';
import 'package:dentiq/core/utils/failure/server_failure.dart';
import 'package:dentiq/core/utils/service/api_service.dart';
import 'package:dentiq/features/chat/data/model/chat_model.dart';
import 'package:dentiq/features/chat/data/repos/chat_repo.dart';

class ChatRepoImpl  implements ChatRepo{
  final ApiService apiService;

  ChatRepoImpl({required this.apiService});
  @override
  Future<Either<ServerFail, ChatModel>> sendMessage({required String message}) async{
  
  try{
    final response=await apiService.post(EndPoints.generateContent,data: {
    
       "contents": [
          {
            "role": "user",
            "parts": [
              {"text": message}
            ]
          }
       ],
       
  
    },headers: {
           "Content-Type": "application/json",
          "x-goog-api-key": EndPoints.apiKey,
    });
    print("API Response: $response");
      final result = ChatModel.fromJson(response);

      return right(result);
  }on ServerFail catch (e) {
      print("Failure: ${e.errMessage}");
      return left(ServerFailure(errMessage: e.errMessage));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

}