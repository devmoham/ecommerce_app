import 'package:ecommerce_app/models/carousel_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final homeServices = HomeServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      final currentUser = authServices.currentUser();
      final products = await homeServices.fetchProducts();
      final carouselItems = await homeServices.fetchCarouselItems();

      emit(HomeLoaded(
        carouselItems: carouselItems,
        products: products,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
