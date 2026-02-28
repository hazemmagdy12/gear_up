class UserModel {
  final String uId;
  final String name;
  final String email;
  final String phone;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.phone,
  });

  // تحويل البيانات لـ Map عشان الفايربيز
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  // استرجاع البيانات من الفايربيز
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}