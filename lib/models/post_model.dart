class PostModel {
  String? name;
  String? uId;
  String? image;
  String? postImage;
  String? dateTime;
  String? text;
  PostModel({
    this.name,
    this.uId,
    this.image,
    this.postImage,
    this.dateTime,
    this.text,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
