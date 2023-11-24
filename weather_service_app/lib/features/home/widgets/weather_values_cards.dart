import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_service_app/resources/app_colors.dart';
import 'package:weather_service_app/widgets/row_space.dart';

class WeatherValuesCards extends StatelessWidget {
  final String img;
  final String title;
  final String value;
  const WeatherValuesCards(
      {super.key, required this.img, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: AppColors.blue,
                ),
                child: SvgPicture.asset(
                  img,
                  width: 40,
                  height: 40,
                ),
              ),
              const RowSpace(10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )
              ),
            ],
          ),
          Text(value),
        ],
      ),
    );
  }
}
