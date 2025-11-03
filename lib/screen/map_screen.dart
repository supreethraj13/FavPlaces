import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final Placelocation initiallocation;
  final bool isSelected;

  MapScreen({
    this.initiallocation = const Placelocation(
      latitude: 37.422,
      longitude: -122.084,
    ),
    this.isSelected = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedlocation;
  void selectloc(LatLng position) {
    setState(() {
      _pickedlocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('your Map'),
        actions: [
          if (widget.isSelected)
            IconButton(
              onPressed: _pickedlocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedlocation);
                    },
              icon: Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initiallocation.latitude,
            widget.initiallocation.longitude,
          ),
          zoom: 13,
        ),
        onTap: widget.isSelected ? selectloc : null,
        markers: _pickedlocation == null && widget.isSelected
            ? <Marker>{}
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position:
                      _pickedlocation ??
                      LatLng(
                        widget.initiallocation.latitude,
                        widget.initiallocation.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
