import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/add_to_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;

  void getCartItems() async {
    emit(CartLoaded(cartItems: dummycart, subTotal: _subtotal));
  }

  void incremetCounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
    final index = dummycart.indexWhere((item) => item.product.id == productId);
    dummycart[index] = dummycart[index].copyWith(quantity: quantity);
    emit(QuantityLoaded(value: quantity, prodctId: productId));
    emit(SubTotalUpdated(subtotal: _subtotal));
  }

  void decremetCounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity < 1 ? 0 : quantity--;
    final index = dummycart.indexWhere((item) => item.product.id == productId);
    dummycart[index] = dummycart[index].copyWith(quantity: quantity);

    emit(QuantityLoaded(value: quantity, prodctId: productId));
        emit(SubTotalUpdated(subtotal: _subtotal));
  }

  double get _subtotal => dummycart.fold(
      0,
      (previousValue, item) =>
          previousValue + item.product.price * item.quantity);
}
