class PostModel {
  String name;
  String uId;
  String image;
  String dateTime;
  String text;
  String postimage;

  PostModel ({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postimage,
  });

  PostModel.fromJson(Map<String,dynamic>json)
  {
    name =json['name'];
    uId =json['uId'];
    image =json['image'];
    dateTime =json['dateTime'];
    text =json['text'];
    postimage =json['postimage'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postimage':postimage,
//01115432559 abdullah mans
    };
  }
}