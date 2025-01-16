import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/views/widgets/counter_widget.dart';
import 'package:ecommerce_app/views_models/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final addToCartModel cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.grey.shade300, Colors.grey]),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Image.network(
              cartItem.product.imagUrl,
              height: 100,
              width: 100,
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartItem.product.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text.rich(
              TextSpan(
                  text: 'Size: ',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: ' ${cartItem.size.name}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
            const SizedBox(
              height: 6,
            ),
            BlocBuilder<CartCubit, CartState>(
              bloc: BlocProvider.of<CartCubit>(context),
              buildWhen: (previous, current) =>
                  current is QuantityLoaded &&
                  current.prodctId == cartItem.product.id,
              builder: (context, state) {
                if (state is QuantityLoaded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CounterWidget(
                          value: state.value,
                          productId: cartItem.product.id,
                          cubit: BlocProvider.of<CartCubit>(context)),
                      const SizedBox(
                        width: 100,
                      ),
                      Text(
                        '\$${(state.value * cartItem.product.price).toStringAsFixed(1)}',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CounterWidget(
                      value: cartItem.quantity,
                      productId: cartItem.product.id,
                      cubit: BlocProvider.of<CartCubit>(context),
                      initialValue: cartItem.quantity,
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Text(
                      '\$${(cartItem.totalPrice.toStringAsFixed(1))}',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                );
              },
            )
          ],
        )
      ],
    );
  }
}
