import 'dart:convert';

class HomeCarouselItemModel {
  final String id;
  final String imgUrl;

  HomeCarouselItemModel({
    required this.id,
    required this.imgUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imgUrl': imgUrl,
    };
  }

  factory HomeCarouselItemModel.fromMap(Map<String, dynamic> map) {
    return HomeCarouselItemModel(
      id: map['id'] as String,
      imgUrl: map['imgUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeCarouselItemModel.fromJson(String source) => HomeCarouselItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<HomeCarouselItemModel> dummyHomeCarouselItems = [
  HomeCarouselItemModel(
    id: '1',
    imgUrl: 'assets/images/1.png',
  ),
  HomeCarouselItemModel(
    id: '2',
    imgUrl: 'assets/images/3.png',
  ),
  HomeCarouselItemModel(
    id: '3',
    imgUrl: 'assets/images/2.png',
  ),
];
