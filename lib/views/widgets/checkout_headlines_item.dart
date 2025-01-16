import 'package:flutter/material.dart';

class CheckoutHeadlinesItem extends StatelessWidget {
  final String title;
  final int? numOfProducts;
  final VoidCallback? onTap;
  const CheckoutHeadlinesItem({
    super.key,
    required this.title,
    this.numOfProducts,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (numOfProducts != null)
                Text(
                  '($numOfProducts)',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
            ],
          ),
          if (onTap != null)
            TextButton(
              onPressed: onTap,
              child: const Text('Edit'),
            ),
        ],
      ),
    );
  }
}
