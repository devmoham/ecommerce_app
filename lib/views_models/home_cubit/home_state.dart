part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadding extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductModel> products;
  final List<HomeCarouselItemModel> dummyHomeCarouselItems;

   HomeLoaded({
    required this.products,
    required this.dummyHomeCarouselItems,
  });
}




