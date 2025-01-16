part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoadding extends CartState {}

final class CartLoaded extends CartState {
  List<addToCartModel> cartItems;
  double subTotal;

  CartLoaded({required this.cartItems, required this.subTotal});
}

final class QuantityLoaded extends CartState {
  final int value;
  final String prodctId;

  QuantityLoaded({required this.value, required this.prodctId});
}

final class SubTotalUpdated extends CartState {
  double subtotal;

  SubTotalUpdated({required this.subtotal});
}
