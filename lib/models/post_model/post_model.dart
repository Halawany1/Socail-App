class PostModel{
  String ?name;
  String ?uId;
  String ?image;
  String ?dateTime;
  String ?text;
  String ?postImage;
  PostModel({
    required this.name,
    required this.uId,
    required this.postImage,
    this.image,
    required this.text,
    required this.dateTime
  });
  PostModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    image=json['image'];
    uId=json['uId'];
    text=json['text'];
    dateTime=json['dateTime'];
    postImage=json['postImage'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'image':image,
      'uId':uId,
      'text':text,
      'dateTime':dateTime,
      'postImage':postImage

    };
  }
}