import 'package:flutter/material.dart';

class AdminBasicState {
  final String name;
  final TimeOfDay openTime;
  final TimeOfDay closedTime;
  final String phone;
  final String address;
  final String description;
  final String? imageUrl;

  const AdminBasicState({
    required this.name,
    required this.openTime,
    required this.closedTime,
    required this.phone,
    required this.address,
    required this.description,
    this.imageUrl,
  });

  AdminBasicState copyWith({
    String? name,
    TimeOfDay? openTime,
    TimeOfDay? closedTime,
    String? phone,
    String? address,
    String? description,
    String? imageUrl,
  }) {
    return AdminBasicState(
      name: name ?? this.name,
      openTime: openTime ?? this.openTime,
      closedTime: closedTime ?? this.closedTime,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  static TimeOfDay _parseTime(
    String? v, {
    TimeOfDay fallback = const TimeOfDay(hour: 9, minute: 0),
  }) {
    if (v == null || v.isEmpty) return fallback;

    // "09:00" or "09:00:00" or "9:0" 모두 대응
    final parts = v.split(':');
    if (parts.length < 2) return fallback;

    final h = int.tryParse(parts[0]) ?? fallback.hour;
    final m = int.tryParse(parts[1]) ?? fallback.minute;
    return TimeOfDay(hour: h.clamp(0, 23), minute: m.clamp(0, 59));
  }

  factory AdminBasicState.fromJson(Map<String, dynamic> json) {
    return AdminBasicState(
      name: (json['name'] as String?) ?? '',
      openTime: _parseTime(json['openTime']),
      closedTime: _parseTime(json['closedTime']),
      phone:
          (json['phoneNumber'] as String?) ?? (json['phone'] as String?) ?? '',
      address: (json['address'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
      imageUrl: json['imageUrl'] as String?,
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
