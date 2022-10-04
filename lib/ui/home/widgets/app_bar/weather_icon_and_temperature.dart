import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../domain/model/weather_model.dart';

class WeatherIconAndTemperature extends StatelessWidget {
  final Weather weather;
  const WeatherIconAndTemperature({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/${weather.icon}.svg',
          width: 110,
          height: 110,
        ),
        const SizedBox(
          width: 10,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            Text(
              '${weather.temperature}°',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                      fontSize: 38,
                      fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 2,
            ),
            Text('C',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
