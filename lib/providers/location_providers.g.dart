// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationServiceHash() => r'051ccb5f5f5886e6f9f8570c507b4f87585edeea';

/// See also [locationService].
@ProviderFor(locationService)
final locationServiceProvider = AutoDisposeProvider<LocationService>.internal(
  locationService,
  name: r'locationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationServiceRef = AutoDisposeProviderRef<LocationService>;
String _$locationPermissionGrantedHash() =>
    r'92c07a6130caa6a00b2657a85a0b97fcba84b563';

/// See also [locationPermissionGranted].
@ProviderFor(locationPermissionGranted)
final locationPermissionGrantedProvider =
    AutoDisposeFutureProvider<bool>.internal(
  locationPermissionGranted,
  name: r'locationPermissionGrantedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationPermissionGrantedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationPermissionGrantedRef = AutoDisposeFutureProviderRef<bool>;
String _$currentLocationHash() => r'74dc817653bb3638f9dc30bd133f0e896a140593';

/// See also [CurrentLocation].
@ProviderFor(CurrentLocation)
final currentLocationProvider =
    AutoDisposeAsyncNotifierProvider<CurrentLocation, LocationData?>.internal(
  CurrentLocation.new,
  name: r'currentLocationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentLocation = AutoDisposeAsyncNotifier<LocationData?>;
String _$selectedLocationHash() => r'4994d89fa9a75fac2bc3cf2c348fd74b50152c6c';

/// See also [SelectedLocation].
@ProviderFor(SelectedLocation)
final selectedLocationProvider =
    AutoDisposeNotifierProvider<SelectedLocation, LocationData?>.internal(
  SelectedLocation.new,
  name: r'selectedLocationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedLocation = AutoDisposeNotifier<LocationData?>;
String _$favoriteLocationsHash() => r'ce1edec0421a7721af6c53cacafa9591e36970bc';

/// See also [FavoriteLocations].
@ProviderFor(FavoriteLocations)
final favoriteLocationsProvider = AutoDisposeAsyncNotifierProvider<
    FavoriteLocations, List<LocationData>>.internal(
  FavoriteLocations.new,
  name: r'favoriteLocationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteLocationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoriteLocations = AutoDisposeAsyncNotifier<List<LocationData>>;
String _$locationSearchHash() => r'93abf5a61162c52341f0c84033421db7ed05cde6';

/// See also [LocationSearch].
@ProviderFor(LocationSearch)
final locationSearchProvider = AutoDisposeAsyncNotifierProvider<LocationSearch,
    List<LocationData>?>.internal(
  LocationSearch.new,
  name: r'locationSearchProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationSearchHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocationSearch = AutoDisposeAsyncNotifier<List<LocationData>?>;
String _$recentLocationsHash() => r'd84e467eca492097f73e1f0747bd0d6791290377';

/// See also [RecentLocations].
@ProviderFor(RecentLocations)
final recentLocationsProvider = AutoDisposeAsyncNotifierProvider<
    RecentLocations, List<LocationData>>.internal(
  RecentLocations.new,
  name: r'recentLocationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentLocationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RecentLocations = AutoDisposeAsyncNotifier<List<LocationData>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
