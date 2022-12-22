class UserModel{
  int id;
  int orderCount;
  String name;
  String phone;
  String email;

  UserModel({
   required this.id,
   required this.orderCount,
   required this.name,
   required this.phone,
   required this.email
});

  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
        id: json["id"],
        orderCount: json["order_count"],
        name:json["f_name"],
        phone: json["phone"],
        email: json["email"],
    );
  }
}