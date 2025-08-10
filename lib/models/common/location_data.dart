// lib/models/common/location_data.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_data.g.dart';

@JsonSerializable()
class LocationData extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String? country;
  final String? state;
  final String? timezone;
  final bool isFavorite;
  final DateTime? lastUpdated;

  const LocationData({
    required this.name,
    required this.lat,
    required this.lon,
    this.country,
    this.state,
    this.timezone,
    this.isFavorite = false,
    this.lastUpdated,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => _$LocationDataFromJson(json);
  Map<String, dynamic> toJson() => _$LocationDataToJson(this);

  LocationData copyWith({
    String? name,
    double? lat,
    double? lon,
    String? country,
    String? state,
    String? timezone,
    bool? isFavorite,
    DateTime? lastUpdated,
  }) {
    return LocationData(
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      country: country ?? this.country,
      state: state ?? this.state,
      timezone: timezone ?? this.timezone,
      isFavorite: isFavorite ?? this.isFavorite,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [name, lat, lon, country, state, timezone, isFavorite, lastUpdated];
}
