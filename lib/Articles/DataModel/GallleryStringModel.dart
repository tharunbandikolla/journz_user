class GalleryStringModel {
  String? imgUrl, message;
  GalleryStringModel({this.imgUrl, this.message});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['GalleryImageUrl'] = this.imgUrl;
    json['GalleryMessage'] = this.message;
    return json;
  }
}
