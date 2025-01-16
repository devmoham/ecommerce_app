import 'package:ecommerce_app/views/widgets/circular_container.dart';
import 'package:flutter/material.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  final Widget child;
  const PrimaryHeaderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple.shade400,
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -190,
              child: TCircularContainer(),
            ),
            Positioned(top: 100, right: -230, child: TCircularContainer()),
            child
          ],
        ),
      ),
    );
  }
}
