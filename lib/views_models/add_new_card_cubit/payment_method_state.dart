part of 'payment_method_cubit.dart';
 class PaymentMethodState {}

final class AddNewCardInitial extends PaymentMethodState {}

final class AddNewCardLoading extends PaymentMethodState {}

final class AddNewCardSuccess extends PaymentMethodState {}

final class FetchingPaymentMethod extends PaymentMethodState {}

final class FetchedPaymentMethod extends PaymentMethodState {
  final List<PaymentCardModel> paymentCards;
  FetchedPaymentMethod(this.paymentCards);
}

final class FetchgPaymentMethodError extends PaymentMethodState {
  final String massage;
  FetchgPaymentMethodError(this.massage);
}

final class ChosenPaymentMethod extends PaymentMethodState {
  final PaymentCardModel chosenPayment;
  ChosenPaymentMethod(this.chosenPayment);
}

final class ConfirmPaymentLoading extends PaymentMethodState {}

final class ConfirmPaymentSuccess extends PaymentMethodState {}

final class ConfirmPaymentfailure extends PaymentMethodState {
  final String massage;
  ConfirmPaymentfailure(this.massage);
}
