import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../providers/location_providers.dart';
import '../../models/common/location_data.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (value.trim().isEmpty) {
      ref.read(locationSearchProvider.notifier).clearResults();
      return;
    }

    _debouncer.run(() {
      ref.read(locationSearchProvider.notifier).searchLocations(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(locationSearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search for a city...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: searchResults.when(
        data: (locations) {
          if (locations == null || locations.isEmpty) {
            return const Center(
              child: Text(
                'Start typing to search for a city',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              return _buildLocationTile(location);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text(
            'Error searching for locations: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationTile(LocationData location) {
    String subtitle = location.country ?? '';
    if (location.state != null) {
      subtitle = '${location.state}, $subtitle';
    }

    return ListTile(
      leading: const Icon(Icons.location_on_outlined),
      title: Text(location.name),
      subtitle: Text(subtitle),
      onTap: () {
        ref.read(selectedLocationProvider.notifier).setLocation(location);
        Navigator.pop(context);
      },
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
