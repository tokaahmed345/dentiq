class LogInModel {
  final String id;
  final String email;


  LogInModel({
    required this.id,
    required this.email,
 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
   
      'email': email,

    };
  }

  factory LogInModel.fromMap(Map<String, dynamic> map) {
    return LogInModel(
      id: map['id'] ?? '',

      email: map['email'] ?? '',
   
    );
  }
}
