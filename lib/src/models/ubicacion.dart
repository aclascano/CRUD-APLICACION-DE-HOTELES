class Ubicacion {
  int? id;
  String? provincia;
  List<String>? ciudad;

  Ubicacion({
    required this.id,
    required this.provincia,
    required this.ciudad
  });

  factory Ubicacion.fromJson(Map<String, dynamic> json) {
    return Ubicacion(
      id: json['id'],
      provincia: json['provincia'],
      ciudad: json['ciudad']!= null ? List<String>.from(json['ciudad']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provincia': provincia,
      'ciudad': ciudad,
    };
  }
}



