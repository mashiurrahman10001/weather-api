import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:intl/intl.dart';

import 'WeatherModel.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;

  const TodaysWeather({Key? key, this.weatherModel}) : super(key: key);

  WeatherType getWeatherType(Current? current) {
    if (current?.isDay == 1) {
      if (current?.condition?.text == "Sunny") return WeatherType.sunny;
      if (current?.condition?.text == "Overcast") return WeatherType.overcast;
      if (current?.condition?.text == "Partly cloudy") return WeatherType.cloudy;
      if (current?.condition?.text == "Cloudy") return WeatherType.cloudy;
      if (current?.condition?.text == "Clear") return WeatherType.sunny;
      if (current?.condition?.text == "Mist") return WeatherType.lightSnow;
      if (current?.condition?.text?.contains("thunder") ?? false) return WeatherType.thunder;
      if (current?.condition?.text?.contains("showers") ?? false) return WeatherType.middleSnow;
      if (current?.condition?.text?.contains("rain") ?? false) return WeatherType.heavyRainy;
    } else {
      if (current?.condition?.text == "Clear") return WeatherType.sunnyNight;
      if (current?.condition?.text == "Partly cloudy") return WeatherType.cloudyNight;
      if (current?.condition?.text?.contains("thunder") ?? false) return WeatherType.thunder;
      if (current?.condition?.text?.contains("showers") ?? false) return WeatherType.middleSnow;
      if (current?.condition?.text?.contains("rain") ?? false) return WeatherType.heavyRainy;
    }
    return WeatherType.middleRainy;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Weather Background
        WeatherBg(
          weatherType: getWeatherType(weatherModel?.current),
          width: MediaQuery.of(context).size.width,
          height: 350, // Increased height for spacing
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Location and Date
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weatherModel?.location?.name ?? "Unknown Location",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(
                        DateTime.tryParse(weatherModel?.current?.lastUpdated ?? "") ?? DateTime.now(),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Weather Icon and Temperature
              Row(
                children: [
                  Image.network(
                    "https:${weatherModel?.current?.condition?.icon ?? ""}",
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${weatherModel?.current?.tempC?.round() ?? "--"}°C",
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        weatherModel?.current?.condition?.text ?? "Unknown",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Weather Details (Humidity, Visibility, Wind, Feels Like)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildWeatherDetail(
                      "Humidity",
                      "${weatherModel?.current?.humidity ?? "--"}%",
                    ),
                    _buildWeatherDetail(
                      "Visibility",
                      "${weatherModel?.current?.visKm?.round() ?? "--"} km",
                    ),
                    _buildWeatherDetail(
                      "Wind",
                      "${weatherModel?.current?.windKph?.round() ?? "--"} km/h",
                    ),
                    _buildWeatherDetail(
                      "Feels Like",
                      "${weatherModel?.current?.feelslikeC?.round() ?? "--"}°C",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherDetail(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
