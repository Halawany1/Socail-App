class UserModel{
  String ?name;
  String ?email;
  String ?phone;
  String ?uId;
  String ?cover;
  String ?bio;
  String ?image;
  bool ?isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    this.cover,
    this.image,
    this.bio,
    required this.isEmailVerified
});
  UserModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    bio=json['bio'];
    cover=json['cover'];
    uId=json['uId'];
    isEmailVerified=json['isEmailVerified'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'cover':cover,
      'image':image,
      'bio':bio,
      'uId':uId,
      'isEmailVerified':isEmailVerified
    };
  }
}