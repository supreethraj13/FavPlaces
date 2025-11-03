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
  // --- ADDED CONTROLLER FOR DESCRIPTION ---
  final _descriptionController = TextEditingController(); 
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
        // --- ADDED DESCRIPTION CHECK ---
        _descriptionController.text.isEmpty || 
        _pickedimage == null ||
        _placelocation == null) {
      // You could show a snackbar error here
      return;
    }
    Provider.of<GreatPlaces>(
      context,
      listen: false,
    ).addPlace(
      _titlecontroller.text,
      // --- PASSED THE DESCRIPTION ---
      _descriptionController.text, 
      _pickedimage!,
      _placelocation!,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add places')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titlecontroller,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // --- ADDED DESCRIPTION TEXTFIELD ---
                    TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3, // Makes it a multi-line box
                      keyboardType: TextInputType.multiline,
                    ),
                    // ---------------------------------
                    const SizedBox(height: 16),
                    ImageInput(_selectimage),
                    const SizedBox(height: 16),
                    LocationInput(_selectedloc),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add place'),
              onPressed: _saveplace,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: Theme.of(context).textTheme.titleMedium,
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