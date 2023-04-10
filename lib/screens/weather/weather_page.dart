import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:intl/intl.dart';
import 'package:projectapp/screens/weather/city_screen.dart';
import 'package:projectapp/model/weather.dart';

// weather main page
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherModel weather = WeatherModel();

  DateTime date = DateTime.now();
  bool isLoading = false;
  dynamic weatherData;

  int? temperature;
  int? temperatureMin;
  int? temperatureMax;
  String? weatherIcon;
  String? cityName;
  String? dayName;
  String? weatherCondition;

  @override
  void initState() {
    isLoading = true;
    updateWidget();
    super.initState();
    getLocationData();
  }

  // get weather data based on current location
  void getLocationData() async {
    weatherData = await WeatherModel().getLocationWeather();
    updateUI(weatherData);
  }

  updateWidget() {
    if (mounted) {
      setState(() {});
    }
  }

  // it will update weather data in UI
  void updateUI(dynamic weatherData) {
    isLoading = true;
    updateWidget();
    if (weatherData == null) {
      temperature = 0;
      temperatureMin = 0;
      temperatureMax = 0;
      weatherIcon = 'cloud';
      cityName = 'Not found';
      weatherCondition = '';
      isLoading = false;
      updateWidget();
      return;
    }

    var temp = weatherData['main']['temp'];
    temperature = temp.toInt();

    var tempMin = weatherData['main']['temp_min'];
    temperatureMin = tempMin.toInt();

    var tempMax = weatherData['main']['temp_max'];
    temperatureMax = tempMax.toInt();

    var condition = weatherData['weather'][0]['id'];
    weatherIcon = weather.getWeatherIcon(condition);

    cityName = weatherData['name'];

    dayName = DateFormat('EEEE').format(date);

    weatherCondition = weatherData['weather'][0]['main'];
    isLoading = false;
    updateWidget();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: isLoading
          ? const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SpinKitFadingFour(
                  color: Colors.blue,
                  size: 25.0,
                ),
              ),
            )
          : Scaffold(
              appBar: buildAppBar(),
              body: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '$cityName',
                          style: const TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(
                          '$dayName',
                          style: const TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 32.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'images/$weatherIcon.png',
                      height: 140,
                      color: Colors.black38,
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            '$temperature°',
                            style: const TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 80.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Text(
                          '$weatherCondition'.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 24.0,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/thermometer_low.png',
                          height: 50,
                          color: Colors.black45,
                        ),
                        Text(
                          '$temperatureMin°',
                          style: const TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 32.0,
                            color: Colors.grey,
                          ),
                        ),
                        Image.asset(
                          'images/thermometer_high.png',
                          height: 50,
                          color: Colors.black45,
                        ),
                        Text(
                          '$temperatureMax°',
                          style: const TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 32.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        highlightColor: Colors.grey,
        splashRadius: 27.5,
        icon: const Icon(Icons.near_me, color: Colors.blueAccent),
        onPressed: () async {
          // get wather data based on user current location
          var weatherData = await weather.getLocationWeather();
          updateUI(weatherData);
        },
      ),
      actions: <Widget>[
        IconButton(
          highlightColor: Colors.grey,
          splashRadius: 27.5,
          icon: const Icon(
            Icons.my_location,
            color: Colors.blueAccent,
          ),
          onPressed: () async {
            var typedName = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const CityScreen();
                },
              ),
            );

            if (typedName != null) {
              // get weather data based on city name
              var weatherData = await weather.getCityWeather(typedName);
              updateUI(weatherData);
            }
          },
        )
      ],
    );
  }
}
