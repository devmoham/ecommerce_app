import 'package:flutter/material.dart';

class totalAndSubtotalWidget extends StatelessWidget {
  final String title;
  final double amount;

  const totalAndSubtotalWidget(
      {super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.grey),
          ),
          Text('\$${amount.toStringAsFixed(1)}',
              style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
