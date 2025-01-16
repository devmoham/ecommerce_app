import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final String productId;
  final int value;
  final dynamic cubit;
  final int? initialValue;
  
  const CounterWidget({
    super.key,
    required this.value,
    required this.productId,
    required this.cubit,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: () => initialValue != null? cubit.decremetCounter(productId,initialValue) : cubit.decremetCounter(productId),
              icon: const Icon(
                Icons.remove_circle,
              )),
          Text(value.toString()),
          IconButton(
              onPressed: () => initialValue != null? cubit.incremetCounter(productId,initialValue) : cubit.incremetCounter(productId),
              icon: const Icon(Icons.add_circle)),
        ],
      ),
    );
  }
}
