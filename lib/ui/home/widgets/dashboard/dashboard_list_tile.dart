import 'package:flutter/material.dart';

class DashboardListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const DashboardListTile({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor:
          Theme.of(context).cardColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: Text(title,
          style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color,
              fontSize: 18,
              fontWeight: FontWeight.w600)),
    );
  }
}
