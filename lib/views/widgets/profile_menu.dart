import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String value;
  final Function()? onPressed;
  final IconData? icon;
  const ProfileMenuItem(
      {super.key,
      required this.title,
      required this.value,
      required this.onPressed,
      this.icon = Icons.arrow_forward_ios});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.grey.shade500),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    icon,
                    size: 15,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
