class PaymentCardModel {
  final String id;
  final String cardnumber;
  final String holdername;
  final String expirydate;
  final String cvv;
  final bool isChosen;


  PaymentCardModel({
    required this.id,
    required this.cardnumber,
    required this.holdername,
    required this.expirydate,
    required this.cvv,
     this.isChosen = false,
  });

  PaymentCardModel copyWith({
    String? id,
    String? cardnumber,
    String? holdername,
    String? expirydate,
    String? cvv,
    bool? isChosen,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      cardnumber: cardnumber ?? this.cardnumber,
      holdername: holdername ?? this.holdername,
      expirydate: expirydate ?? this.expirydate,
      cvv: cvv ?? this.cvv,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}

List<PaymentCardModel> dummPaymentCards = [
  PaymentCardModel(
    id: '1',
    cardnumber: '1234 5678 9012 3456',
    holdername: 'Mohamed Mostafa',
    expirydate: '12/23',
    cvv: '123',
    
  ),
  PaymentCardModel(
    id: '2',
    cardnumber: '1234 5678 9012 3466',
    holdername: 'John Doe',
    expirydate: '12/23',
    cvv: '123',
  ),
  PaymentCardModel(
    id: '3',
    cardnumber: '1234 5678 9012 3477',
    holdername: 'Tim Smith',
    expirydate: '12/23',
    cvv: '123',
  ),
];
