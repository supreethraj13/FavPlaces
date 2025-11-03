import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'provider/great_places_provider.dart';
import './screen/places_list_screens.dart';
import './screen/add_place_screen.dart';
import './screen/places_details_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          canvasColor: Colors.amber,
        ),
        debugShowCheckedModeBanner: false,
        home: PlacesListScreens(),
        routes: {
          AddPlaceScreen.routename: (ctx) => AddPlaceScreen(),
          PlacesDetailsScreen.routeName: (ctx) => PlacesDetailsScreen(),
        },
      ),
    );
  }
}
