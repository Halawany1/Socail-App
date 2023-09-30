class MessageModel{
  String ?receiverId;
  String ?dateTime;
  String ?senderId;
  String ?text;
  int ?arrange;
  MessageModel({
    this.text,
    this.dateTime,
    this.receiverId,
    this.senderId,
    this.arrange
  });
  MessageModel.fromJson(Map<String,dynamic> json){
    text=json['text'];
    arrange=json['arrange'];
    dateTime=json['dateTime'];
    receiverId=json['receiverId'];
    senderId=json['senderId'];
  }
  Map<String,dynamic> toMap(){
    return {
      'senderId':senderId,
      'dateTime':dateTime,
      'arrange':arrange,
      'receiverId':receiverId,
      'text':text,
    };
  }
}