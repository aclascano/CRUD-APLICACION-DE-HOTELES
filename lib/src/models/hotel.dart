
import 'package:proyectofinal/src/models/disponibilidad.dart';

import 'contacto.dart';

class Hotel {
  String? nombre;
  String? ubicacion;
  int? calificacion;
  double?precioBase;
  String? descripcion;
  List<String>? servicios; 
  Contacto? contacto;
  FechaDisponibilidad? disponibilidad;
  String? fotografia;

  Hotel({
    required this.nombre,
    required this.ubicacion,
    required this.calificacion,
    required this.precioBase,
    required this.descripcion,
    required this.servicios,
    required this.contacto,
    required this.disponibilidad,
    required this.fotografia
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
  return Hotel(
    nombre: json['nombre'],
    ubicacion: json['ubicacion'],
    calificacion: json['calificacion'],
    precioBase: json['precioBase'],
    descripcion: json['descripcion'],
    servicios: json['servicios'] != null ? List<String>.from(json['servicios']) : null,
    contacto: json['contacto'] is Map<String, dynamic> ? Contacto.fromJson(json['contacto']) : null,
    disponibilidad: json['disponibilidad'] is Map<String, dynamic> ? FechaDisponibilidad.fromJson(json['disponibilidad']) : null,
    fotografia: json['fotografia']
  );
}




  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'ubicacion': ubicacion,
      'calificacion': calificacion,
      'precioBase':precioBase,
      'descripcion': descripcion,
      'servicios': servicios,
      'contacto': contacto?.toJson(),
      'disponibilidad': disponibilidad?.toJson(),
      'fotografia': fotografia
    };
  }
}