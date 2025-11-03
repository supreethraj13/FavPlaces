import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helper/loaction_helper.dart';
import '../screen/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectedloc;

  LocationInput(this.onSelectedloc);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewimg;

  void showpreview(double lat, double lng) {
    final staticmapimg = LoactionHelper.locationpreviewimg(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewimg = staticmapimg;
    });
  }

  Future<void> getuselocation() async {
    final locdata = await Location().getLocation();
    showpreview(locdata.latitude!, locdata.longitude!);
    widget.onSelectedloc(locdata.latitude, locdata.longitude);
  }

  Future<void> _selectonMap() async {
    final selectloc = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(isSelected: true),
        fullscreenDialog: true,
      ),
    );
    if (selectloc == null) {
      return;
    }
    showpreview(selectloc.latitude, selectloc.longitude);
    widget.onSelectedloc(selectloc.latitude, selectloc.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewimg == null
              ? Text('no location data', textAlign: TextAlign.center)
              : Image.network(
                  _previewimg!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('current location'),
              onPressed: getuselocation,
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.map),
              label: Text('select on map'),
              onPressed: _selectonMap,
            ),
          ],
        ),
      ],
    );
  }
}
