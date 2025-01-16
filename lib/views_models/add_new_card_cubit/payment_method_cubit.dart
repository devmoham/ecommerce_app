import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(AddNewCardInitial());

   String selectedPaymentId = dummPaymentCards.first.id;

  void getcardinfo(
      String cardnumber, String holdername, String expirydate, String cvv) {
    emit(AddNewCardLoading());
    final carditem = PaymentCardModel(
        id: DateTime.now().toIso8601String(),
        cardnumber: cardnumber,
        holdername: holdername,
        expirydate: expirydate,
        cvv: cvv);
    Future.delayed(const Duration(seconds: 1), () {
      dummPaymentCards.add(carditem);
      emit(AddNewCardSuccess());
    });
  }

  void fetchPaymentMethods() {
    emit(FetchingPaymentMethod());
    Future.delayed(Duration(seconds: 1), () {
      if (dummPaymentCards.isNotEmpty) {
        final chosenPaymentMethod = dummPaymentCards.firstWhere(
          (paymentCard) => paymentCard.isChosen == true,
          orElse: () => dummPaymentCards.first,
        );
        emit(FetchedPaymentMethod(dummPaymentCards));
        emit(ChosenPaymentMethod(chosenPaymentMethod));
      } else {
        emit(FetchgPaymentMethodError('No payment methods found'));
      }
    });
  }

  void changePaaymentMethod(String id) {
     selectedPaymentId = id;
    final tempChosenPaymentMethod = dummPaymentCards
        .firstWhere((paymentCard) => paymentCard.id == selectedPaymentId);
    emit(ChosenPaymentMethod(tempChosenPaymentMethod));
  }

  void confirmPaymentMethod() {
    emit(ConfirmPaymentLoading());
    Future.delayed(Duration(seconds: 1), () {

      var chosenPaymentMethod = dummPaymentCards
          .firstWhere((paymentCard) => paymentCard.id == selectedPaymentId);
      var previousPaymentMethod = dummPaymentCards
          .firstWhere((paymentCard) => paymentCard.isChosen == true, orElse: () => dummPaymentCards.first );

      chosenPaymentMethod = chosenPaymentMethod.copyWith(isChosen: true);
      previousPaymentMethod = previousPaymentMethod.copyWith(isChosen: false);

      var chosenIndex = dummPaymentCards
          .indexWhere((paymentCard) => paymentCard.id == chosenPaymentMethod.id);
      var previousIndex = dummPaymentCards
          .indexWhere((paymentCard) => paymentCard.id == previousPaymentMethod.id);

       dummPaymentCards[chosenIndex] = chosenPaymentMethod  ;
       dummPaymentCards[previousIndex] = previousPaymentMethod ;
      emit(ConfirmPaymentSuccess());
    });
  }
}
