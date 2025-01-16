import 'package:ecommerce_app/models/carousel_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  void getHomeData() {
    emit(HomeLoadding());
    Future.delayed(Duration(seconds: 2), () {
      emit(HomeLoaded(
          products: products, dummyHomeCarouselItems: dummyHomeCarouselItems));
    });
  }

 
}
