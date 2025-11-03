import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../provider/great_places_provider.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routename = '/add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titlecontroller = TextEditingController();
  File? _pickedimage;
  Placelocation? _placelocation;

  void _selectimage(File pickedimage) {
    _pickedimage = pickedimage;
  }

  void _selectedloc(double lat, double lng) {
    _placelocation = Placelocation(latitude: lat, longitude: lng);
  }

  void _saveplace() {
    if (_titlecontroller.text.isEmpty ||
        _pickedimage == null ||
        _placelocation == null) {
      // You could show a snackbar error here
      return;
    }
    Provider.of<GreatPlaces>(
      context,
      listen: false,
    ).addPlace(_titlecontroller.text, _pickedimage!, _placelocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add places')),
      body: Column(
        // crossAxisAlignment.stretch is good!
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                // Increased padding for better spacing
                padding: const EdgeInsets.all(16.0), 
                child: Column(
                  children: [
                    TextField(
                      controller: _titlecontroller,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        // Added an outline border
                        border: OutlineInputBorder(), 
                      ),
                    ),
                    // Increased spacing
                    const SizedBox(height: 16), 
                    ImageInput(_selectimage),
                    const SizedBox(height: 16),
                    LocationInput(_selectedloc),
                  ],
                ),
              ),
            ),
          ),
          // --- Improved Button Styling ---
          Padding(
            // Added padding to keep it from the screen edges/safe area
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0), 
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add place'),
              onPressed: _saveplace,
              style: ElevatedButton.styleFrom(
                // Made the button taller
                padding: const EdgeInsets.symmetric(vertical: 16.0), 
                // Rounded corners
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                // Made text larger
                textStyle: Theme.of(context).textTheme.titleMedium,
                // Removed the default splash/tap padding
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, 
                elevation: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}