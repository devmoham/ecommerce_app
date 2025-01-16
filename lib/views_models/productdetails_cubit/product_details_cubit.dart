import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/product_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  int quantity = 1;
  ProductSize? selectedsize;

  void getproductDetails(String id) {
    emit(ProductDetailsLoadding());
    Future.delayed(const Duration(seconds: 2), () {
      final selectedProduct = products.firstWhere(
        (item) => item.id == id,
      );
      emit(ProductDetailsLoaded(product: selectedProduct));
    });
  }

  void incremetCounter(String productId) {
    quantity++;
    emit(QuantityLoaded(value: quantity));
  }

  void decremetCounter(String productId) {
    quantity < 1 ? 0 : quantity--;
    emit(QuantityLoaded(value: quantity));
  }

  void selsctedSize(ProductSize size) {
    selectedsize = size;
    emit(ProductSelectedSize(size: size));
  }

  void addTocart(String productId) {
    emit(AddingToCart());
    Future.delayed(const Duration(seconds: 2), () {
      final cartItem = addToCartModel(
          Id: DateTime.now().toIso8601String(),
          product: products.firstWhere((item) => item.id == productId),
          size: selectedsize!,
          quantity: quantity);
      dummycart.add(cartItem);
      emit(AddedToCart(productId: productId));
    });
  }
}
