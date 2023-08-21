import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyectofinal/src/screens/actualizar_hotel.dart';

import '../bloc/hotel_bloc.dart';
import '../models/hotel.dart';
import '../screens/hoteles_index.dart';
import '../services/hotel_service.dart';

class HotelDetailScreen extends StatelessWidget {
  final int hotelId;
  final HotelManager _hotelManager = HotelManager();
  final HotelService hotelService = HotelService();

  HotelDetailScreen({required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles del hotel',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0, // Sin sombra
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: FutureBuilder<Hotel?>(
        future: _hotelManager.getHotelDetailByIndex(hotelId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error al cargar los detalles del hotel'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No se encontraron detalles del hotel'));
          } else {
            var hotel = snapshot.data!;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hotel ${hotel.nombre}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Image.network(
                    hotel.fotografia!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Información del Hotel',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Calificación: ${hotel.calificacion}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Ubicación: ${hotel.ubicacion}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Precio Base: ${hotel.precioBase}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Descripción: ${hotel.descripcion}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Servicios: ${hotel.servicios?.join(', ')}',
                    style: TextStyle(fontSize: 16),
                  ),
                  /////////////////////////////////////////////////////////////////////////
                  SizedBox(height: 12),
                  Text(
                    'Disponibilidad:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Desde: ${DateFormat('dd/MM/yyyy').format(hotel.disponibilidad?.startRange ?? DateTime.now())}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Hasta: ${DateFormat('dd/MM/yyyy').format(hotel.disponibilidad?.endRange ?? DateTime.now())}',
                    style: TextStyle(fontSize: 16),
                  ),

                  /////////////////////////////////////////////////////////////////////////
                  SizedBox(height: 11),
                  Text(
                    'Contacto:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Correo: ${hotel.contacto?.correo}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Número de Teléfono: ${hotel.contacto?.numeroTelefono}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Instagram: ${hotel.contacto?.instagram}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Facebook: ${hotel.contacto?.facebook}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Sitio Web: ${hotel.contacto?.sitioWeb}',
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 15),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ////////ACTUALIZAR
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ActualizarHotelScreen(hotelId: hotelId,)));
                          },
                          icon: Icon(Icons.update),
                          label: Text('Actualizar'),
                        ),
                        SizedBox(width: 25),

                        ////////////////////ELIMINAR
                        ElevatedButton.icon(
                          onPressed: () {
                            hotelService.deleteHotelByIndex(hotelId);

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Hotel Elimindado'),
                                content: Text(
                                    'El hotel se ha eliminado exitosamente.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HotelesScreen()));
                                    },
                                    child: Text('Aceptar'),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(Icons.delete_forever),
                          label: Text('Eliminar'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
