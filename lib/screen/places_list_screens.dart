import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../provider/great_places_provider.dart';
import './places_details_screen.dart';

class PlacesListScreens extends StatelessWidget {
  const PlacesListScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AddPlaceScreen.routename);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(
          context,
          listen: false,
        ).fetchandSetplaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    // --- IMPROVEMENT 1: A better "empty list" widget ---
                    // We pass this new custom widget as the 'child'
                    // so it's not rebuilt unnecessarily.
                    child: const _EmptyList(),
                    builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                        ? ch! // This 'ch' is the _EmptyList widget
                        : ListView.builder(
                            padding: const EdgeInsets.all(8.0), // Added padding
                            itemCount: greatPlaces.items.length,
                            // --- IMPROVEMENT 2: Replaced ListTile with a Card ---
                            itemBuilder: (ctx, i) => Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              clipBehavior: Clip.antiAlias, // Rounded corners
                              elevation: 3,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    PlacesDetailsScreen.routeName,
                                    arguments: greatPlaces.items[i].id,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      // Hero widget for smooth image animation
                                      Hero(
                                        tag: greatPlaces.items[i].id,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.file(
                                            greatPlaces.items[i].image,
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Expanded to make text fill the space
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              greatPlaces.items[i].title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              greatPlaces
                                                  .items[i].location.address!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
      ),
    );
  }
}

// --- NEW WIDGET for the empty list state ---
class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.map_outlined,
            size: 80,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            'No places yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the "+" icon to add your first place!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}