class SignUpModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String gender;

  SignUpModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
    );
  }
}
