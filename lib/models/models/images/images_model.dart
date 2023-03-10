class ImagesModel{
  List<dynamic>? images;

  ImagesModel({this.images});

  factory ImagesModel.formJson(Map json){
    return ImagesModel(images: json['images']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Params: $images}';
  }
}