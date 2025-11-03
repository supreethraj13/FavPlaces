import 'dart:io';
import 'package:flutter/material.dart';

import '../helper/db_helper.dart'; // Corrected typo from 'helper'
import '../models/place.dart';
import '../helper/loaction_helper.dart'; // Corrected typo from 'helper'

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  Place findbyId(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
    String pickedtitle,
    String pickedDescription, // --- ADDED THIS ---
    File pickedimage,
    Placelocation pickedlocation,
  ) async {
    // Corrected typo from 'LoactionHelper'
    final address = await LoactionHelper.getplaceaddress(
      pickedlocation.latitude,
      pickedlocation.longitude,
    );
    final updatedloc = Placelocation(
      latitude: pickedlocation.latitude,
      longitude: pickedlocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedtitle,
      description: pickedDescription, // --- ADDED THIS ---
      location: updatedloc,
      image: pickedimage,
    );
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'description': newPlace.description, // --- ADDED THIS ---
      'img': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address!,
    });
  }

  Future<void> fetchandSetplaces() async {
    final datalist = await DbHelper.getData('places');
    _items = datalist
        .map(
          (items) => Place(
            id: items['id'],
            title: items['title'],
            description: items['description'], // --- ADDED THIS ---
            location: Placelocation(
              latitude: items['loc_lat'],
              longitude: items['loc_lng'],
              address: items['address'],
            ),
            image: File(items['img']),
          ),
        )
        .toList();
    notifyListeners();
  }
}