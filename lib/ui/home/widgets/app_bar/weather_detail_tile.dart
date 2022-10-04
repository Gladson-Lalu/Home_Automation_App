import 'package:flutter/material.dart';

class WeatherDetailTile extends StatelessWidget {
  final String title;
  final String assetPath;
  const WeatherDetailTile({
    Key? key,
    required this.assetPath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            width: 26,
            color: Theme.of(context)
                .textTheme
                .labelMedium!
                .color,
            height: 26,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
