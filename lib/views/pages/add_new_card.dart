import 'package:ecommerce_app/views/widgets/text_field_widget.dart';
import 'package:ecommerce_app/views_models/add_new_card_cubit/payment_method_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentMethodCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Add New Card'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelWithTextField(
                      controller: _cardNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your card number';
                        }
                        if (value.length < 13 || value.length > 19) {
                          return 'Card number must be between 13 and 19 digits';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Card number must contain only digits';
                        }
                        return null;
                      },
                      maxLength: 19,
                      keyboardType: TextInputType.number,
                      label: 'Card Number',
                      prefixIcon: Icons.credit_card,
                      hint: 'Enter card number'),
                  const SizedBox(height: 20),
                  LabelWithTextField(
                      controller: _cardHolderNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the cardholder\'s name';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'Name must contain only letters and spaces';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      label: 'Card Holder Name',
                      prefixIcon: Icons.person,
                      hint: 'Enter card holder name'),
                  const SizedBox(height: 20),
                  LabelWithTextField(
                      controller: _expiryDateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the expiry date';
                        }

                        // Accept both M/YY and MM/YY formats
                        if (!RegExp(r'^\d{1,2}/\d{2}$').hasMatch(value)) {
                          return 'Expiry date must be in M/YY or MM/YY format';
                        }

                        final parts = value.split('/');
                        int month = int.parse(parts[0]);
                        int year = int.parse('20${parts[1]}');

                        // Check if the month is valid (1-12)
                        if (month < 1 || month > 12) {
                          return 'Invalid month';
                        }

                        // Check if the card has expired
                        DateTime currentDate = DateTime.now();
                        DateTime expiryDate = DateTime(year, month);
                        if (expiryDate.isBefore(
                            DateTime(currentDate.year, currentDate.month))) {
                          return 'Card is expired';
                        }

                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            5), // Limit length to 5
                        ExpiryDateTextInputFormatter(), // Auto-insert slash
                      ],
                      keyboardType: TextInputType.datetime,
                      label: 'Expiry Date',
                      prefixIcon: Icons.date_range,
                      hint: 'Enter expiry date'),
                  const SizedBox(height: 20),
                  LabelWithTextField(
                      controller: _cvvController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the CVV';
                        }
                        if (value.length < 3 || value.length > 4) {
                          return 'CVV must be 3 or 4 digits';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'CVV must contain only digits';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      label: 'Cvv',
                      prefixIcon: Icons.password,
                      hint: 'Enter cvv'),
                  const Spacer(),
                  Builder(builder: (context) {
                    return BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
                      bloc: BlocProvider.of<PaymentMethodCubit>(context),
                      buildWhen: (previous, current) =>
                          current is AddNewCardLoading ||
                          current is AddNewCardSuccess,
                      listenWhen: (previous, current) =>
                          current is AddNewCardSuccess,
                      listener: (context, state) {
                        if (state is AddNewCardSuccess) {
                          Navigator.of(context).pop();
                        }
                      },
                      builder: (context, state) {
                        if (state is AddNewCardLoading) {
                          return const SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: null,
                                child: CircularProgressIndicator.adaptive(),
                              ));
                        }
                        return SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  return BlocProvider.of<PaymentMethodCubit>(
                                          context)
                                      .getcardinfo(
                                          _cardNumberController.text,
                                          _cardHolderNameController.text,
                                          _expiryDateController.text,
                                          _cvvController.text);
                                }
                              },
                              child: Text(
                                'Add Card',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                              ),
                            ));
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom TextInputFormatter to automatically add a slash after MM
class ExpiryDateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    String oldText = oldValue.text;

    // Allow backspacing (deletion) as normal
    if (oldText.length > text.length) {
      return newValue; // Let deletion happen as normal
    }

    // Restrict total length to 5 characters (MM/YY format)
    if (text.length > 5) {
      return oldValue; // Don't allow more than 5 characters
    }

    // If one digit is typed (e.g., '2'), add the slash
    if (text.length == 1 && !text.contains('/')) {
      text = text + '/'; // Add slash after the month
    }
    // If two digits are typed (e.g., '12'), add the slash
    else if (text.length == 2 && !text.contains('/')) {
      text = text + '/'; // Add slash after the month
    }

    // Ensure no more than one slash in the text
    if (text.length > 3 && text[2] == '/' && text.lastIndexOf('/') > 2) {
      text = text.substring(0, 3) + text.substring(4);
    }

    // Return the updated text and cursor position
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
