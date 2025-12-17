import 'package:flutter/material.dart';

class AdminBasicState {
  final String name;
  final TimeOfDay openTime;
  final TimeOfDay closedTime;
  final String phone;
  final String address;
  final String description;

  final List<String> imageUrls;

  final String? imageUrl;

  const AdminBasicState({
    required this.name,
    required this.openTime,
    required this.closedTime,
    required this.phone,
    required this.address,
    required this.description,
    this.imageUrls = const <String>[],
    this.imageUrl,
  });

  AdminBasicState copyWith({
    String? name,
    TimeOfDay? openTime,
    TimeOfDay? closedTime,
    String? phone,
    String? address,
    String? description,
    List<String>? imageUrls,
    String? imageUrl,
  }) {
    return AdminBasicState(
      name: name ?? this.name,
      openTime: openTime ?? this.openTime,
      closedTime: closedTime ?? this.closedTime,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  static TimeOfDay _parseTime(
    String? v, {
    TimeOfDay fallback = const TimeOfDay(hour: 9, minute: 0),
  }) {
    if (v == null || v.isEmpty) return fallback;

    // "09:00" / "09:00:00" / "9:0"
    final parts = v.split(':');
    if (parts.length < 2) return fallback;

    final h = int.tryParse(parts[0]) ?? fallback.hour;
    final m = int.tryParse(parts[1]) ?? fallback.minute;
    return TimeOfDay(hour: h.clamp(0, 23), minute: m.clamp(0, 59));
  }

  static ({TimeOfDay open, TimeOfDay close}) _parseOpenHoursRange(
    String? v, {
    TimeOfDay openFallback = const TimeOfDay(hour: 9, minute: 0),
    TimeOfDay closeFallback = const TimeOfDay(hour: 18, minute: 0),
  }) {
    if (v == null || v.isEmpty)
      return (open: openFallback, close: closeFallback);
    final parts = v.split('-').map((e) => e.trim()).toList();
    if (parts.length != 2) return (open: openFallback, close: closeFallback);
    return (
      open: _parseTime(parts[0], fallback: openFallback),
      close: _parseTime(parts[1], fallback: closeFallback),
    );
  }

  factory AdminBasicState.fromJson(Map<String, dynamic> json) {
    final openTimeRaw = json['openTime'] as String?;
    final closedTimeRaw = json['closedTime'] as String?;

    final openHoursRaw = json['openHours'] as String?;
    final range = _parseOpenHoursRange(openHoursRaw);

    final open = openTimeRaw != null && openTimeRaw.isNotEmpty
        ? _parseTime(openTimeRaw)
        : range.open;

    final close = closedTimeRaw != null && closedTimeRaw.isNotEmpty
        ? _parseTime(
            closedTimeRaw,
            fallback: const TimeOfDay(hour: 18, minute: 0),
          )
        : range.close;

    final rawUrls = json['imageUrls'];
    final urls = (rawUrls is List)
        ? rawUrls
              .whereType<dynamic>()
              .map((e) => e.toString())
              .where((e) => e.isNotEmpty)
              .toList()
        : <String>[];

    final single = json['imageUrl'] as String?;
    final derivedPrimary = (single != null && single.isNotEmpty)
        ? single
        : (urls.isNotEmpty ? urls.first : null);

    return AdminBasicState(
      name: (json['name'] as String?) ?? '',
      openTime: open,
      closedTime: close,
      phone:
          (json['phoneNumber'] as String?) ?? (json['phone'] as String?) ?? '',
      address: (json['address'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
      imageUrls: urls,
      imageUrl: derivedPrimary,
    );
  }

  static String _fmtTime(TimeOfDay t) {
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    return '$hh:$mm:00';
  }

  Map<String, dynamic> toSaveBody() {
    return {
      'name': name,
      'openTime': _fmtTime(openTime),
      'closedTime': _fmtTime(closedTime),
      'phoneNumber': phone,
      'address': address,
      'description': description,
    };
  }
}
