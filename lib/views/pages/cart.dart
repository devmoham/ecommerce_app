import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/utills/app_routes.dart';
import 'package:ecommerce_app/views/widgets/total_subtotal_widget.dart';
import 'package:ecommerce_app/views_models/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

import '../widgets/cart_item_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CartCubit();
        cubit.getCartItems();
        return cubit;
      },
      child: Builder(builder: (context) {
        return BlocBuilder<CartCubit, CartState>(
          bloc: BlocProvider.of<CartCubit>(context),
          buildWhen: (previous, current) =>
              current is CartLoadding || current is CartLoaded,
          builder: (context, state) {
            if (state is CartLoadding) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            } else if (state is CartLoaded) {
              final cartItems = state.cartItems;
              if (cartItems.isEmpty) {
                return Center(
                  child: Image.asset(
                    'assets/images/Empty-Cart-.png',
                    height: 300,
                    width: 300,
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dummycart.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return CartItemWidget(cartItem: cartItem);
                      },
                      separatorBuilder: (context, index) => Divider(
                        endIndent: 10,
                        indent: 10,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    Divider(
                      endIndent: 10,
                      indent: 10,
                      color: Colors.grey.shade200,
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      bloc: BlocProvider.of<CartCubit>(context),
                      buildWhen: (previous, current) =>
                          current is SubTotalUpdated,
                      builder: (context, subtotalState) {
                        if (subtotalState is SubTotalUpdated) {
                          return Column(
                            children: [
                              totalAndSubtotalWidget(
                                  title: 'Subtotal',
                                  amount: subtotalState.subtotal),
                              const totalAndSubtotalWidget(
                                  title: 'Shipping', amount: 10),
                              const SizedBox(height: 4),
                              Dash(
                                dashColor: Colors.grey.shade300,
                                length: 370,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              totalAndSubtotalWidget(
                                  title: 'Total Amount',
                                  amount: subtotalState.subtotal + 10),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            totalAndSubtotalWidget(
                                title: 'Subtotal', amount: state.subTotal),
                            const totalAndSubtotalWidget(
                                title: 'Shipping', amount: 10),
                            const SizedBox(height: 4),
                            Dash(
                              dashColor: Colors.grey.shade300,
                              length: 370,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            totalAndSubtotalWidget(
                                title: 'Total Amount',
                                amount: state.subTotal + 10),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 40.0),
                    Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () =>
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(AppRoute.chekoutRoute),
                            child: Text(
                              'Checkout',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                            ),
                          )),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox(
                child: Text('Something Wrong'),
              );
            }
          },
        );
      }),
    );
  }
}
