import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabelWithTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String label;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? icon;
  final String hint;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  LabelWithTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.maxLength,
     this.keyboardType,
    required this.label,
     this.icon,
    required this.hint,
    this.inputFormatters,
     required this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<LabelWithTextField> createState() => _LabelWithTextFieldState();
}

class _LabelWithTextFieldState extends State<LabelWithTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
            inputFormatters: widget.inputFormatters,
            controller: widget.controller,
            validator: widget.validator,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                prefixIcon: Icon(widget.prefixIcon),
                suffixIcon: widget.suffixIcon,
                hintText: widget.hint,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey[700]),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide.none),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ))),
      ],
    );
  }
}
