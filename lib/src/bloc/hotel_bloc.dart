import '../models/hotel.dart';
import '../services/hotel_service.dart';

class HotelManager {
  final HotelService _hotelService = HotelService();

  bool isValidCalificacion(int? calificacion) {
    return calificacion != null && calificacion >= 1 && calificacion <= 5;
  }

  Future<void> addHotel(Hotel hotel) async {
    if (!isValidCalificacion(hotel.calificacion)) {
      throw Exception('La calificación debe estar entre 1 y 5.');
    }

    List<Hotel> hotelesExistentes = await _hotelService.getHotels();
    bool nombreRepetido =
        hotelesExistentes.any((h) => h.nombre == hotel.nombre);
    if (nombreRepetido) {
      throw Exception('Ya existe un hotel con el mismo nombre.');
    }
    await _hotelService.addHotel(hotel);
  }

  Future<List<Map<String, dynamic>>> getHotelGeneral() async {
    try {
      List<Hotel> hotelList = await _hotelService.getHotels();
      DateTime today = DateTime.now(); // Fecha actual

      return hotelList.map((hotel) {
        String availabilityStatus = 'Hoy no está disponible';

        if (hotel.disponibilidad != null) {
          
          if (today.isAfter(hotel.disponibilidad!.startRange!) &&
              today.isBefore(hotel.disponibilidad!.endRange!)) {
            availabilityStatus = 'Hoy está disponobile';
          }
        }
        return {
          'fotografia': hotel.fotografia,
          'nombre': hotel.nombre,
          'calificacion': hotel.calificacion,
          'ubicacion': hotel.ubicacion,
          'precioBase': hotel.precioBase?.toDouble(),
          'disponibilidad': availabilityStatus,
        };
      }).toList();
    } catch (e) {
      print('Error al obtener la lista de hoteles: $e');
      return [];
    }
  }

  Future<Hotel?> getHotelDetailByIndex(int index) async {
    List<Hotel> hotelesList = await _hotelService.getHotels();

    if (index >= 0 && index < hotelesList.length) {
      return hotelesList[index];
    } else {
      return null;
    }
  }
}
