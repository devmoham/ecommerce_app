import 'package:ecommerce_app/utills/app_routes.dart';
import 'package:ecommerce_app/views_models/check_cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyShippingAndPayment extends StatelessWidget {
  final String title;
  final bool isPayment;
  const EmptyShippingAndPayment({
    super.key,
    required this.title,
    required this.isPayment,
  });

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return InkWell(
      onTap: () {
        if (isPayment) {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(AppRoute.addcardRoute)
              .then((value) => checkoutCubit.getCheckout());
        } else {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(AppRoute.locationRoute).then((value) => checkoutCubit.getCheckout());
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.add,
                  size: 30,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
