class SocialUserModel {
  String name;
  String email;
  String phone;
  String uId;
  String image;
  String cover;
  String bio;
bool isEmailVerified;

  SocialUserModel ({
   this.email,
    this.phone,
    this.name,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
});

  SocialUserModel.fromJson(Map<String,dynamic>json)
  {
email =json['email'];
phone =json['phone'];
name =json['name'];
uId =json['uId'];
image =json['image'];
cover =json['cover'];
bio =json['bio'];
isEmailVerified =json['isEmailVerified'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,

//01115432559 abdullah mans
    };
  }
}