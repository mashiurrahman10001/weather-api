import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'WeatherModel.dart'; // Make sure this is imported to use ForecastDay

class FutureForcastListItem extends StatelessWidget {
  final ForecastDay forecastday; // Corrected class name

  const FutureForcastListItem({Key? key, required this.forecastday}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        children: [
          Image.network("https:${forecastday.day?.condition?.icon ?? ""}"),
          Expanded(
            child: Text(
              DateFormat.MMMEd()
                  .format(DateTime.parse(forecastday.date ?? "")),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              forecastday.day?.condition?.text ?? "",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              "^${forecastday.day?.maxtempC?.round() ?? 0}/${forecastday.day?.mintempC?.round() ?? 0}",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
