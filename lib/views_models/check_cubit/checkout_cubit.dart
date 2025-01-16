import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/add_to_cart_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  void getCheckout() {
    emit(CheckoutLoading());
    final cartItems = dummycart;
    final subtotal = dummycart.fold(
        0.0,
        (previousValue, item) =>
            previousValue + item.product.price * item.quantity);
    final numOfProducts = dummycart.fold(
        0, (previousValue, item) => previousValue + item.quantity);

      final  chosenPaymentCard = dummPaymentCards.firstWhere((element) => element.isChosen == true,orElse: () => dummPaymentCards.first ,);
      final  chosenAddress = dummylocations.firstWhere((element) => element.isChosen == true,orElse: () => dummylocations.first ,);
    emit(CheckoutLoaded(
        cartItems: cartItems,
        totalAmount: subtotal + 10,
        numOfProducts: numOfProducts,
        chosenPaymentCard: chosenPaymentCard,
        chosenAddress: chosenAddress
        ));
  }
}
