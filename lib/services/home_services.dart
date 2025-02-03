import 'package:ecommerce_app/models/carousel_model.dart';
import 'package:ecommerce_app/models/catagory_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utills/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> fetchProducts();
  Future<List<HomeCarouselItemModel>> fetchCarouselItems();
  Future<List<CategoryModel>> fetchCategories();
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> fetchProducts() async {
    final result = await firestoreServices.getCollection<ProductItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(
        data,
      ),
    );
    return result;
  }

  @override
  Future<List<HomeCarouselItemModel>> fetchCarouselItems() async {
    final result = await firestoreServices.getCollection<HomeCarouselItemModel>(
      path: ApiPaths.announcements(),
      builder: (data, documentId) => HomeCarouselItemModel.fromMap(
        data,
      ),
    );
    return result;
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final result = await firestoreServices.getCollection<CategoryModel>(
      path: ApiPaths.categories(),
      builder: (data, documentId) => CategoryModel.fromMap(
        data,
      ),
    );
    return result;
  }
}