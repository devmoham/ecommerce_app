// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum ProductSize { S, M, L, XL }

class ProductItemModel {
  final String id;
  final String name;
  final String imagUrl;
  final double price;
  final String catagory;
  final String rating;

  ProductItemModel({
    required this.id,
    required this.name,
    required this.imagUrl,
    required this.price,
    required this.catagory,
    this.rating = '4.8',
  });

  ProductItemModel copyWith({
    String? id,
    String? name,
    String? imagUrl,
    double? price,
    String? catagory,
    int? quantity,
    String? rating,
  }) {
    return ProductItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imagUrl: imagUrl ?? this.imagUrl,
      price: price ?? this.price,
      catagory: catagory ?? this.catagory,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imagUrl': imagUrl,
      'price': price,
      'catagory': catagory,
      'rating': rating,
    };
  }

  factory ProductItemModel.fromMap(Map<String, dynamic> map) {
    return ProductItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imagUrl: map['imagUrl'] as String,
      price: map['price'] as double,
      catagory: map['catagory'] as String,
      rating: map['rating'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductItemModel.fromJson(String source) => ProductItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<ProductItemModel> products = [
  ProductItemModel(
      id: '1',
      name: 'Iron Trasparent',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/1/Electric-Iron-Transparent-Images.png',
      price: 50,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '2',
      name: 'Bug',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/12/Kelly-Purse-Background-PNG.png',
      price: 70,
      catagory: 'Accessories'),
  ProductItemModel(
      id: '3',
      name: 'T-Shirt',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/15/Shirts-Download-Free-PNG.png',
      price: 20,
      catagory: 'Clothes'),
  ProductItemModel(
      id: '4',
      name: 'SweatShirt',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/15/Hoodies-Transparent-Image.png',
      price: 30,
      catagory: 'Clothes'),
  ProductItemModel(
      id: '5',
      name: 'Keyboard',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/13/Multimedia-Keyboard-PNG-Background.png',
      price: 10,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '6',
      name: 'Camera',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/13/Nikon-PNG-Photo-Image.png',
      price: 250,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '7',
      name: 'Toaster',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/2/Electric-Toaster-Transparent-Free-PNG.png',
      price: 43,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '8',
      name: 'VR-Glasses',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/13/Oculus-No-Background.png',
      price: 10,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '9',
      name: 'Mouse',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/2/Gaming-Pc-Mouse-PNG-Clipart-Background.png',
      price: 500,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '10',
      name: 'iPad',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/13/Tablet-Keyboard-Download-Free-PNG.png',
      price: 10,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '11',
      name: 'Pc',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/13/Computer-Transparent-File.png',
      price: 1300,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '12',
      name: 'Van',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/1/Electric-Fan-PNG-Transparent-Images.png',
      price: 10,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '13',
      name: 'Hat',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/7/Black-Cap-Transparent-Background.png',
      price: 10,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '14',
      name: 'iron trasparent',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/12/Vacuum-Cleaner-Clip-Art-Transparent-File.png',
      price: 100,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '15',
      name: 'Coat',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/15/Jacket-Grey-Free-PNG.webp',
      price: 10,
      catagory: 'Clothes'),
  ProductItemModel(
      id: '16',
      name: 'Hat',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/15/Great-Hat-PNG-Pic-Background.png',
      price: 10,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '17',
      name: 'Jbl',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/6/JBL-Audio-Speakers-Amplifier-Transparent-PNG.png',
      price: 25,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '18',
      name: 'Van',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/1/Fan-PNG-Clipart-Background.png',
      price: 10,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '19',
      name: 'Play Station 5',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/13/Playstation-Transparent-File.png',
      price: 1000,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '20',
      name: 'Iphone 15',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/15/iPhone-14-PNG-Background.png',
      price: 3000,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '21',
      name: 'Iphone 13',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/13/iPhone-13-Pro-PNG-Clipart-Background.png',
      price: 2500,
      catagory: 'Electrioncs'),
  ProductItemModel(
      id: '23',
      name: 'Keyboard',
      imagUrl:
          'https://www.pngplay.com/wp-content/uploads/13/Multimedia-Keyboard-Transparent-PNG.png',
      price: 10,
      catagory: 'Electrioncs'),
];
