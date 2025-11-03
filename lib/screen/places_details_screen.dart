import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/great_places_provider.dart';
import './map_screen.dart';

class PlacesDetailsScreen extends StatelessWidget {
  const PlacesDetailsScreen({super.key});
  static const routeName = '/palacedetailscreen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final selectedpalace = Provider.of<GreatPlaces>(
      context,
      listen: false,
    ).findbyId(id as String);
    return Scaffold(
      appBar: AppBar(title: Text(selectedpalace.title)),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedpalace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            selectedpalace.location.address!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) =>
                      MapScreen(initiallocation: selectedpalace.location),
                ),
              );
            },
            child: Text('view on map'),
          ),
        ],
      ),
    );
  }
}
