import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/hotel.dart';


class HotelService {
  final CollectionReference hotelsCollection = FirebaseFirestore.instance.collection('hotels');

  Future<List<Hotel>> getHotels() async {
    try {
      QuerySnapshot querySnapshot = await hotelsCollection.get();
      return querySnapshot.docs.map((doc) => Hotel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error al obtener los hoteles: $e');
      return [];
    }
  }
  
  Future<Hotel?> getHotelById(String hotelId) async {
    try {
      DocumentSnapshot documentSnapshot = await hotelsCollection.doc(hotelId).get();
      if (documentSnapshot.exists) {
        return Hotel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error al obtener el hotel por ID: $e');
      return null;
    }
  }

  Future<void> addHotel(Hotel hotel) async {
    try {
      Map<String, dynamic> hotelMap = hotel.toJson();
      hotelMap['disponibilidad'] = hotel.disponibilidad?.toJson();
      await hotelsCollection.add(hotel.toJson());
      
    } catch (e) {
      print('Error al agregar el hotel: $e');
    }
  }

  Future<void> updateHotelByIndex(int index, Hotel hotel) async {
    try {
      List<String> hotelIds = await _getHotelIds(); 
    if (index >= 0 && index < hotelIds.length) {
      String id = hotelIds[index];
      await hotelsCollection.doc(id).update(hotel.toJson());
    } else {
      print('Índice fuera de rango');
    }
    } catch (e) {
      print('Error al actualizar el hotel: $e');
    }
  }

  Future<void> deleteHotelByIndex(int index) async {
  try {
    List<String> hotelIds = await _getHotelIds(); 
    if (index >= 0 && index < hotelIds.length) {
      String id = hotelIds[index];
      await hotelsCollection.doc(id).delete();
    } else {
      print('Índice fuera de rango');
    }
  } catch (e) {
    print('Error al eliminar el hotel: $e');
  }
}

Future<List<String>> _getHotelIds() async {
  try {
    QuerySnapshot snapshot = await hotelsCollection.get();
    List<String> hotelIds = snapshot.docs.map((doc) => doc.id).toList();
    return hotelIds;
  } catch (e) {
    print('Error al obtener IDs de hoteles: $e');
    return [];
  }
}
}