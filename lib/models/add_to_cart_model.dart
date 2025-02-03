import 'package:ecommerce_app/models/product_model.dart';

class addToCartModel {
  String Id;
  ProductItemModel product;
  ProductSize size;
  int quantity;

  addToCartModel({
    required this.Id,
    required this.product,
    required this.size,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;

  addToCartModel copyWith({
    String? Id,
    ProductItemModel? product,
    ProductSize? size,
    int? quantity,
  }) {
    return addToCartModel(
      Id: Id ?? this.Id,
      product: product ?? this.product,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}

List<addToCartModel> dummycart = [];
