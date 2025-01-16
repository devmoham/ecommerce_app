import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final double height;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final String? text;
  final bool isLoading;

  MainButton({
    super.key,
    this.height = 60,
    this.onTap,
    this.backgroundColor = Colors.deepPurple,
    this.foregroundColor = Colors.white,
    this.text,
    this.isLoading = false,
  }) {
    assert(text != null || isLoading == true);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Text(
                text!,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
      ),
    );
  }
}
