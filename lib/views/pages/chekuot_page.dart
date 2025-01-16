import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/utills/app_routes.dart';
import 'package:ecommerce_app/views/widgets/checkout_headlines_item.dart';
import 'package:ecommerce_app/views/widgets/empty_shipping_payment.dart';
import 'package:ecommerce_app/views/widgets/payment_method_item.dart';
import 'package:ecommerce_app/views/widgets/payment_method_bottom_sheet.dart';
import 'package:ecommerce_app/views_models/add_new_card_cubit/payment_method_cubit.dart';
import 'package:ecommerce_app/views_models/check_cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  Widget builditemMethod(BuildContext context, PaymentCardModel? chosenCard) {
    if (chosenCard != null) {
      return PaymentMethodItem(
        paymentCard: chosenCard,
        onItemTapped: () => showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.65,
              child: BlocProvider(
                create: (context) {
                  final cubit = PaymentMethodCubit();
                  cubit.fetchPaymentMethods();
                  return cubit;
                },
                child: const PaymentMethodBottomSheet(),
              ),
            );
          },
        ).then(
            (value) => BlocProvider.of<CheckoutCubit>(context).getCheckout()),
      );
    } else {
      return const EmptyShippingAndPayment(
        title: 'Add Payment Method',
        isPayment: true,
      );
    }
  }

  Widget _buildShippingItem(
      LocationItemModel? chosenAddress, BuildContext context) {
    if (chosenAddress != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                chosenAddress.imgUrl,
                width: 140,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 24),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chosenAddress.city,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${chosenAddress.city}, ${chosenAddress.country}',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ],
        ),
      );
    } else {
      return const EmptyShippingAndPayment(
        title: 'Add shipping address',
        isPayment: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CheckoutCubit();
        cubit.getCheckout();
        return cubit;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Checkout Page'),
            centerTitle: true,
          ),
          body: Builder(builder: (context) {
            final cubit = BlocProvider.of<CheckoutCubit>(context);
            return BlocBuilder<CheckoutCubit, CheckoutState>(
              bloc: cubit,
              buildWhen: (previous, current) =>
                  current is CheckoutLoading ||
                  current is CheckoutLoaded ||
                  current is CheckoutError,
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CheckoutLoaded) {
                  final cartItems = state.cartItems;
                  final chosenPaymentCard = state.chosenPaymentCard;
                  final chosenAddress = state.chosenAddress;

                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CheckoutHeadlinesItem(
                              title: 'Address',
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(AppRoute.locationRoute)
                                    .then((value) => cubit.getCheckout());
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            _buildShippingItem(chosenAddress, context),
                            const SizedBox(
                              height: 16,
                            ),
                            CheckoutHeadlinesItem(
                                title: 'Products',
                                numOfProducts: state.numOfProducts),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => Divider(
                                endIndent: 10,
                                indent: 10,
                                color: Colors.grey.shade200,
                              ),
                              itemCount: cartItems.length,
                              itemBuilder: (context, index) {
                                final cartItem = cartItems[index];
                                return Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Colors.grey.shade300,
                                            Colors.grey
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartItem.product.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                  text: 'Size: ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color: Colors
                                                              .grey.shade500,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          ' ${cartItem.size.name}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    )
                                                  ]),
                                            ),
                                            const SizedBox(
                                              width: 110,
                                            ),
                                            Text(
                                              '\$${(cartItem.totalPrice.toStringAsFixed(1))}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const CheckoutHeadlinesItem(
                              title: 'Payment Method',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            builditemMethod(context, chosenPaymentCard),
                            const SizedBox(
                              height: 10,
                            ),
                            Dash(
                              dashColor: Colors.grey.shade300,
                              length: 370,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                      '\$${state.totalAmount.toStringAsFixed(1)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: SizedBox(
                                  height: 60,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Procced to buy',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is CheckoutError) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox(
                    child: Text('lllllllllllllll'),
                  );
                }
              },
            );
          })),
    );
  }
}
