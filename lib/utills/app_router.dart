import 'package:ecommerce_app/utills/app_routes.dart';
import 'package:ecommerce_app/views/pages/add_new_card.dart';
import 'package:ecommerce_app/views/pages/add_new_location_.dart';
import 'package:ecommerce_app/views/pages/button_navbar.dart';
import 'package:ecommerce_app/views/pages/chekuot_page.dart';
import 'package:ecommerce_app/views/pages/login_page.dart';
import 'package:ecommerce_app/views/pages/product_details.dart';
import 'package:ecommerce_app/views/pages/profile_page.dart';
import 'package:ecommerce_app/views/pages/regiter_page.dart';
import 'package:ecommerce_app/views_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/views_models/location_cubit/location_cubit.dart';
import 'package:ecommerce_app/views_models/productdetails_cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.homeRoute:
        return (MaterialPageRoute(builder: (_) => CustomButtonNavBar()));

      case AppRoute.loginRoute:
        return (MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: LoginPage(),
                )));

      case AppRoute.registerRoute:
        return (MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: RegisterPage(),
                )));

      case AppRoute.chekoutRoute:
        return (MaterialPageRoute(builder: (_) => CheckoutPage()));

      case AppRoute.addcardRoute:
        return (MaterialPageRoute(builder: (_) => AddNewCardPage()));

      case AppRoute.productDetailsRoute:
        String productId = settings.arguments as String;
        return (MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) {
                    final cubit = ProductDetailsCubit();
                    cubit.getproductDetails(productId);
                    return cubit;
                  },
                  child: ProductPageDetails(
                    productId: productId,
                  ),
                )));

      case AppRoute.locationRoute:
        return (MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) {
                    final cubit = LocationCubit();
                    cubit.fetchLocations();
                    return cubit;
                  },
                  child: AddNewLocation(),
                )));

      case AppRoute.profileRoute:
        return (MaterialPageRoute(builder: (_) => ProfilePage()));

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('no route found'),
                  ),
                ));
    }
  }
}
