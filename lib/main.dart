import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dynamic_weather_icons/dynamic_weather_icons.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text("Weather App",
            style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 30
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("data:image/jpeg;base64,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"),
              fit: BoxFit.cover
            ),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: apicall(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return Column(
                        children: [

                          SizedBox(height: 30),


                          Text('📍${snapshot.data['name'].toString()}',
                            style: TextStyle(
                                fontSize: 75,
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(snapshot.data['description'].toString(),
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontStyle: FontStyle.italic
                            ),
                          ),
                          SizedBox(height: 20),

                          Icon(
                            WeatherIcon.getIcon('wi-owm-day-200'),
                            color: Colors.white,
                            size: 70.0,
                          ),

                          SizedBox(height: 30),

                          Text('${snapshot.data['temp'].toString()}°C',
                                      style: TextStyle(
                                        fontSize: 100,
                                        color: Colors.white,
                                         ),
                                       ),

                          SizedBox(height: 1),


                          Text('feels like ${snapshot.data['feels_like'].toString()}°C',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontStyle: FontStyle.italic ,
                            ),
                          ),

                          SizedBox(height: 25),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                               
                                width: 100,
                                height: 75,

                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, //color of border
                                      width: 2, //width of border
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('min',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text('${snapshot.data['temp_min'].toString()}°C',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 10),

                              Container(
                                width: 100,
                                height: 75,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, //color of border
                                      width: 2, //width of border
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('max',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text('${snapshot.data['temp_max'].toString()}°C',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                          ),
                          SizedBox(height: 70),





                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(

                                width: 100,
                                height: 75,

                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, //color of border
                                      width: 2, //width of border
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('pressure',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text('${snapshot.data['pressure'].toString()}',
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 10),

                              Container(
                                width: 100,
                                height: 75,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, //color of border
                                      width: 2, //width of border
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('humidity',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text('${snapshot.data['humidity'].toString()}',
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),

                              Container(

                                width: 100,
                                height: 75,

                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, //color of border
                                      width: 2, //width of border
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('wind speed',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text('${snapshot.data['speed'].toString()}',
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),

                              Container(

                                width: 100,
                                height: 75,

                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white, //color of border
                                      width: 2, //width of border
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('clouds',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text('${snapshot.data['all'].toString()}',
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                          ),



                        ],
                      );
                    }
                    else{
                      return CircularProgressIndicator();
                    }
                  }
              )
            ],
          ),

        )
    );

  }
}
var icon;
Future apicall() async {
  final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=11542823490b7fbc3699f1079ca374e0&units=metric");
  final response = await http.get(url);
  print(response.body);
  final json =  jsonDecode(response.body);
  print(json['weather'][0]['description']);
  // return json['weather'][0]['description'];

  final output = {
    'description':json['weather'][0]['description'],
    'temp' : json['main']['temp'],
    'name' : json['name'],
    'cod' : json['cod'],
    'temp_min' : json['main']['temp_min'],
    'temp_max' : json['main']['temp_max'],
    'feels_like' : json['main']['feels_like'],
    'pressure' : json['main']['pressure'],
    'humidity' : json['main']['humidity'],
    'speed' : json['wind']['speed'],
    'all' : json['clouds']['all'],
    'icon' :json['weather'][0]['icon'],
  };
  return output;
}

