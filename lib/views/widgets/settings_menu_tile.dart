import 'package:flutter/material.dart';

class SettingsMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final Widget? trailing;
  const SettingsMenuTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subTitle,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
        color: Colors.deepPurple.shade900,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 19),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black54),
      ),
      trailing: trailing,
    );
  }
}
