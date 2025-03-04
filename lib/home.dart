import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:intl/intl.dart';
import 'future_forcast_;istitem.dart';
import 'todays_weather.dart';
import 'WeatherModel.dart';
import 'api_service.dart';
 // Fixed typo here
import 'hourly_weather_listitem.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  final _textFieldController = TextEditingController();
  String queryText = "auto:ip";

  Future<void> _showTextInputDialog(BuildContext context) async {
    String? text = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search Location'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Search by city, zip"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                if (_textFieldController.text.isNotEmpty) {
                  Navigator.pop(context, _textFieldController.text);
                }
              },
            ),
          ],
        );
      },
    );

    if (text != null && text.isNotEmpty) {
      setState(() {
        queryText = text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Flutter Weather App"),
        actions: [
          IconButton(
            onPressed: () async {
              _textFieldController.clear();
              await _showTextInputDialog(context);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                queryText = "auto:ip";
              });
            },
            icon: const Icon(Icons.my_location),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<WeatherModel?>(
          future: apiService.getWeatherData(queryText),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Error has occurred",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;

              return SingleChildScrollView(
                // Ensures all content is scrollable if overflow occurs
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TodaysWeather(weatherModel: weatherModel),
                      const SizedBox(height: 10),
                      const Text(
                        "Weather By Hours",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            var hour = weatherModel
                                ?.forecast?.forecastday?[0].hour?[index];
                            return hour != null
                                ? HourlyWeatherListItem(hour: hour)
                                : const SizedBox();
                          },
                          itemCount: weatherModel
                              ?.forecast?.forecastday?[0].hour?.length ??
                              0,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Next 7 Days Weather",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var forecastDay =
                          weatherModel?.forecast?.forecastday?[index];
                          return forecastDay != null
                              ? FutureForcastListItem(forecastday: forecastDay)
                              : const SizedBox();
                        },
                        itemCount:
                        weatherModel?.forecast?.forecastday?.length ?? 0,
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(
              child: Text(
                "No data available",
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
