part of 'product_details_cubit.dart';

class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoadding extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductItemModel product;

  ProductDetailsLoaded({required this.product});
}

final class QuantityLoaded extends ProductDetailsState {
  final int value;

  QuantityLoaded({required this.value});
}

final class ProductSelectedSize extends ProductDetailsState {
  final ProductSize size;

  ProductSelectedSize({required this.size});
}

final class AddingToCart extends ProductDetailsState {}

final class AddedToCart extends ProductDetailsState {
  String productId;

  AddedToCart({required this.productId});
}
