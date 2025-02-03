import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  final String name;
  final String imagUrl;
  final String prodcount;

  CategoryModel({
    required this.name,
    required this.imagUrl,
    required this.prodcount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imagUrl': imagUrl,
      'prodcount': prodcount,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] as String,
      imagUrl: map['imagUrl'] as String,
      prodcount: map['prodcount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<CategoryModel> catagoreys = [
  CategoryModel(
      name: 'New Arrivals',
      imagUrl: 'assets/images/catagories/t-shirt-.png',
      prodcount: '208'),
  CategoryModel(
      name: 'Clothes',
      imagUrl: 'assets/images/catagories/Polo-Black-PNG-Free-File-Download.png',
      prodcount: '358'),
  CategoryModel(
      name: 'Bags',
      imagUrl:
          'assets/images/catagories/jokta3eqk4qoo8ccrvgfps5t2e-05f50dc3eefb990a207120b52cbe94fa.png',
      prodcount: '160'),
  CategoryModel(
      name: 'Shoes',
      imagUrl:
          'assets/images/catagories/jeans-t-shirt-shoulder-denim-sleeve-jeans-77b19fd2eb02c454fdfe17daf2e30e15.png',
      prodcount: '230'),
  CategoryModel(
      name: 'Elecrtonics',
      imagUrl: 'assets/images/catagories/laptop.png',
      prodcount: '150'),
  CategoryModel(
      name: 'Accessories',
      imagUrl: 'assets/images/catagories/u77v1hhjettravshgkmdkus43l.png',
      prodcount: '240')
];
