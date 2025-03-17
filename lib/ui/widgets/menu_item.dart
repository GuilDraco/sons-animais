import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const MenuItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.blue,
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      onTap: onTap,
    );
  }
}
