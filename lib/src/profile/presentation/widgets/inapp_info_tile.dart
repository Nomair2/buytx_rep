import 'package:flutter/material.dart';

class InappInfoTile extends StatelessWidget {
  const InappInfoTile({
    super.key, required this.value, required this.title, required this.onTap,
  });
  final String value;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleMedium,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall,
          ),
        ],
      ),
    );
  }
}