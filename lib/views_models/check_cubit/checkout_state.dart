part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final List<addToCartModel> cartItems;
  final double totalAmount;
  final int numOfProducts;
  final PaymentCardModel? chosenPaymentCard;
  final LocationItemModel? chosenAddress;
  

  CheckoutLoaded({
    required this.cartItems,
    required this.totalAmount,
    required this.numOfProducts,
    required this.chosenPaymentCard,
    required this.chosenAddress,
  
  });
}

final class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError(
    this.message,
  );
}