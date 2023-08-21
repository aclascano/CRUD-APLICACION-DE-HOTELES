import 'package:cloud_firestore/cloud_firestore.dart';

class FechaDisponibilidad {
  final DateTime? startRange;
  final DateTime? endRange;

  FechaDisponibilidad({
    required this.startRange,
    required this.endRange,
  });


  Map<String, dynamic> toJson() {
    return {
      'startRange': Timestamp.fromDate(startRange!),
      'endRange': Timestamp.fromDate(endRange!),
    };
  }

  factory FechaDisponibilidad.fromJson(Map<String, dynamic> json) {
    return FechaDisponibilidad(
      startRange: (json['startRange'] as Timestamp).toDate(),
      endRange: (json['endRange'] as Timestamp).toDate(),
    );
  }
  
}