import 'package:ecommerce_app/utills/app_routes.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:ecommerce_app/views_models/add_new_card_cubit/payment_method_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final paymentMethodsCubit = BlocProvider.of<PaymentMethodCubit>(context);

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 10.0, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    width: 45,
                    height: 6,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ),
              ),
              Text(
                'Payment Methods',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              BlocBuilder(
                bloc: paymentMethodsCubit,
                buildWhen: (previous, current) =>
                    current is FetchedPaymentMethod ||
                    current is FetchedPaymentMethod ||
                    current is FetchingPaymentMethod,
                builder: (_, state) {
                  if (state is FetchingPaymentMethod) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is FetchedPaymentMethod) {
                    final paymentCards = state.paymentCards;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: paymentCards.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final paymentCard = paymentCards[index];
                        return Card(
                          elevation: 0,
                          child: ListTile(
                            onTap: () {
                              paymentMethodsCubit
                                  .changePaaymentMethod(paymentCard.id);
                            },
                            leading: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade200,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 8.0),
                                child: Image.asset(
                                  'assets/images/Mastercard-PNG-HD-Quality.png',
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            title: Text(paymentCard.cardnumber),
                            subtitle: Text(paymentCard.holdername),
                            trailing: BlocBuilder<PaymentMethodCubit,
                                PaymentMethodState>(
                              bloc: paymentMethodsCubit,
                              buildWhen: (previous, current) =>
                                  current is ChosenPaymentMethod,
                              builder: (context, state) {
                                if (state is ChosenPaymentMethod) {
                                  final chosenPaymentCard = state.chosenPayment;
                                  return Radio<String>(
                                    value: paymentCard.id,
                                    groupValue: chosenPaymentCard.id,
                                    onChanged: (id) {
                                      paymentMethodsCubit
                                          .changePaaymentMethod(id!);
                                    },
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is FetchgPaymentMethodError) {
                    return Center(
                      child: Text(state.massage),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {},
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(AppRoute.addcardRoute);
                    },
                    leading: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.add),
                        )),
                    title: const Text('Add New Card'),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
                bloc: paymentMethodsCubit,
                listenWhen: (previous, current) =>
                    current is ConfirmPaymentSuccess,
                listener: (context, state) {
                  if (state is ConfirmPaymentSuccess) {
                    return Navigator.pop(context);
                  }
                },
                buildWhen: (previous, current) =>
                    current is ConfirmPaymentLoading ||
                    current is ConfirmPaymentSuccess ||
                    current is ConfirmPaymentfailure,
                builder: (context, state) {
                  if (state is ConfirmPaymentLoading) {
                    return MainButton(
                      isLoading: true,
                      onTap: null,
                    );
                  } else {
                    return MainButton(
                      text: 'Confirm Payment',
                      onTap: () {
                        paymentMethodsCubit.confirmPaymentMethod();
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
