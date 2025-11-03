import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/great_places_provider.dart';
import './map_screen.dart';

class PlacesDetailsScreen extends StatelessWidget {
  const PlacesDetailsScreen({super.key});
  static const routeName = '/place-detail-screen'; // Fixed typo

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final selectedPlace = Provider.of<GreatPlaces>( // Fixed typo
      context,
      listen: false,
    ).findbyId(id as String);
    
    return Scaffold(
      appBar: AppBar(title: Text(selectedPlace.title)),
      // Wrapped in SingleChildScrollView to prevent overflow
      body: SingleChildScrollView( 
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Hero(
                tag: selectedPlace.id,
                child: Image.file(
                  selectedPlace.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // --- ADDED DESCRIPTION DISPLAY ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                selectedPlace.description,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            // ---------------------------------

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                selectedPlace.location.address!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              icon: const Icon(Icons.map_outlined),
              label: const Text('View on Map'),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => MapScreen(
                      initiallocation: selectedPlace.location,
                      // isSelecting: false, 
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20), // Added bottom padding
          ],
        ),
      ),
    );
  }
}