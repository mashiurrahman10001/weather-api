class WeatherModel {
  final Location location;
  final Current current;
  final Forecast forecast;

  WeatherModel({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }
}

class Location {
  final String name;
  final String country;

  Location({
    required this.name,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      country: json['country'],
    );
  }
}

class Current {
  final int isDay;
  final double tempC;
  final double feelslikeC;
  final int humidity;
  final double windKph;
  final double visKm;
  final Condition condition;
  final String lastUpdated;

  Current({
    required this.isDay,
    required this.tempC,
    required this.feelslikeC,
    required this.humidity,
    required this.windKph,
    required this.visKm,
    required this.condition,
    required this.lastUpdated,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      isDay: json['is_day'] ?? 0,
      tempC: json['temp_c']?.toDouble() ?? 0.0,
      feelslikeC: json['feelslike_c']?.toDouble() ?? 0.0,
      humidity: json['humidity'] ?? 0,
      windKph: json['wind_kph']?.toDouble() ?? 0.0,
      visKm: json['vis_km']?.toDouble() ?? 0.0,
      condition: Condition.fromJson(json['condition']),
      lastUpdated: json['last_updated'] ?? '',
    );
  }
}

class Condition {
  final String text;
  final String icon;

  Condition({
    required this.text,
    required this.icon,
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
    );
  }
}

class Forecast {
  final List<ForecastDay> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastday: (json['forecastday'] as List)
          .map((item) => ForecastDay.fromJson(item))
          .toList(),
    );
  }
}

class ForecastDay {
  final String date;
  final Day day;
  final List<Hour> hour;

  ForecastDay({
    required this.date,
    required this.day,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'],
      day: Day.fromJson(json['day']),
      hour: (json['hour'] as List)
          .map((item) => Hour.fromJson(item))
          .toList(),
    );
  }
}

class Day {
  final double maxtempC;
  final double mintempC;
  final Condition condition;

  Day({
    required this.maxtempC,
    required this.mintempC,
    required this.condition,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: json['maxtemp_c']?.toDouble() ?? 0.0,
      mintempC: json['mintemp_c']?.toDouble() ?? 0.0,
      condition: Condition.fromJson(json['condition']),
    );
  }
}

class Hour {
  final String time;
  final double tempC;
  final Condition condition;
  final double windKph;
  final int humidity;

  Hour({
    required this.time,
    required this.tempC,
    required this.condition,
    required this.windKph,
    required this.humidity,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      time: json['time'] ?? '',
      tempC: json['temp_c']?.toDouble() ?? 0.0,
      condition: Condition.fromJson(json['condition']),
      windKph: json['wind_kph']?.toDouble() ?? 0.0,
      humidity: json['humidity'] ?? 0,
    );
  }
}
