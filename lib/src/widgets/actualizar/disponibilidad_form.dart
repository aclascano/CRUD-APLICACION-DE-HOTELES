import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../data/hotelcontacto_data.dart';
import '../../data/hoteldisponibilidad_data.dart';
import '../../data/hotelfotografia_data.dart';
import '../../data/hotelinfo_data.dart';
import '../../models/hotel.dart';
import '../../screens/actualizar_hotel.dart';
import '../date_picker.dart';
import 'contacto_form.dart';


class DisponibilidadFormUpdate extends StatelessWidget {
  final Hotel? hotel;
  final Hotelinfo info;
  final HotelDisponibilidad disponibilidad;
  final HotelContacto contacto;
  final HotelFotografia fotografia;
  final ActualizarHotelScreen actualizarHotelScreen;
  final int hotelId;

  List<DateTime?> _selectedDates = [];

  DisponibilidadFormUpdate(
      {
      required this.hotelId,
      required this.hotel,
      required this.info,
      required this.disponibilidad,
      required this.contacto,
      required this.fotografia,
      required this.actualizarHotelScreen});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Paso 2. Información sobre disponibilidad'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        width: 300, // Ajusta el ancho según sea necesario
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Fechas disponibles',
                              style: TextStyle(
                                fontSize: 18, // Tamaño de fuente
                                fontWeight:
                                    FontWeight.bold, // Peso de la fuente
                              ),
                            ),
                            SizedBox(height: 16),
                            FechaDisponibilidadPicker(
                              onDatesSelected: (selectedDates) {
                                _selectedDates = selectedDates;
                                if (selectedDates != null) {
                                 
                                  disponibilidad.startRange =
                                      selectedDates.first;
                                  disponibilidad.endRange = selectedDates.last;

                                  print(
                                      'Inicio del rango: ${disponibilidad.startRange}');
                                  print(
                                      'Fin del rango: ${disponibilidad.endRange}');
                                }
                              },
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Cerrar el diálogo
                              },
                              child: Text('Cerrar'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text('Seleccionar fechas'),
            ),
            if (_selectedDates.isNotEmpty)
              Column(
                children: [
                  Text('Fechas seleccionadas:'),
                  Column(
                    children: _selectedDates
                        .map((date) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                DateFormat('dd/MM/yyyy').format(date!),
                                style: TextStyle(fontSize: 16),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            SizedBox(height: 38),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para retroceder a la pantalla anterior
                    Navigator.pop(context);
                  },
                  child: Text('Retroceder'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print(info.nombre);
                print(info.calificacion);
                print(info.precioBase);
                print(info.descripcion);
                print(info.servicios);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactoFormUpdate(
                          hotel: hotel,
                          hotelId: hotelId,
                          info: info,
                          disponibilidad: disponibilidad,
                          contacto: contacto,
                          fotografia: fotografia,
                          actualizarHotelScreen: actualizarHotelScreen,
                        ),
                      ),
                    );
                  },
                  child: Text('Siguiente'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
