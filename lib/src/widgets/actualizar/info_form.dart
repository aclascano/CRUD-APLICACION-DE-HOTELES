import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/hotelcontacto_data.dart';
import '../../data/hoteldisponibilidad_data.dart';
import '../../data/hotelfotografia_data.dart';
import '../../data/hotelinfo_data.dart';
import '../../models/hotel.dart';
import '../../models/ubicacion.dart';
import '../../screens/actualizar_hotel.dart';
import '../../services/ubicacion_api_service.dart';
import 'disponibilidad_form.dart';

class InfoFormUpdate extends StatefulWidget {
  final Hotel? hotel;
  final Hotelinfo info;
  final HotelDisponibilidad disponibilidad;
  final HotelContacto contacto;
  final HotelFotografia fotografia;
  final ActualizarHotelScreen actualizarHotelScreen;
  final int hotelId;

  const InfoFormUpdate({
    required this.hotelId,
    required this.hotel,
    required this.info,
    required this.disponibilidad,
    required this.contacto,
    required this.fotografia,
    required this.actualizarHotelScreen,
  });

  @override
  _InfoFormUpdateState createState() => _InfoFormUpdateState();
}

class _InfoFormUpdateState extends State<InfoFormUpdate> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController calificacionController = TextEditingController();
  TextEditingController precioBaseController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController serviciosController = TextEditingController();

  String nombre = "";
  int calificacion = 0;
  double precioBase = 0.00;
  String descripcion = "";
  List<String>? servicios;

  List<Ubicacion>? _list;
  String? _selectedProvincia;
  String? _selectedCiudad;
  String? ubicacionFinal;
  List<String>? _ciudades;

  loadUbicacion() async {
    UbicacionService service = UbicacionService();
    _list = await service.getUbicicacion();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadUbicacion();
  }

  @override
  void dispose() {
    nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nombreController.text = widget.hotel?.nombre ?? '';
    nombre = widget.hotel?.nombre ?? '';

    calificacionController.text = widget.hotel?.calificacion?.toString() ?? '';
    calificacion = widget.hotel?.calificacion?.toInt() ?? 0;

    precioBaseController.text = widget.hotel?.precioBase?.toString() ?? '';
    precioBase = widget.hotel?.precioBase?.toDouble() ?? 0.00;

    descripcionController.text = widget.hotel?.descripcion?.toString() ?? '';
    descripcion = widget.hotel?.descripcion ?? '';

    calificacionController.text = widget.hotel?.calificacion?.toString() ?? '';
    calificacion = widget.hotel?.calificacion?.toInt() ?? 0;

    serviciosController.text = widget.hotel?.servicios?.join(',') ?? '';
    servicios = widget.hotel?.servicios;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Paso 1. Información del hotel'),
            SizedBox(height: 16),
            TextField(
                controller: nombreController,
                onChanged: (value) => nombre = value,
                decoration: InputDecoration(labelText: 'Nombre')),
            SizedBox(height: 16),
            Center(
              child: _list == null
                  ? const Center(
                      child: SizedBox.square(
                          dimension: 50.0, child: CircularProgressIndicator()),
                    )
                  : Column(
                      children: [
                        DropdownButtonFormField<String>(
                          onChanged: (newValue) {
                            setState(() {
                              _selectedProvincia = newValue;
                              _selectedCiudad = null;
                              _ciudades = _list!
                                  .firstWhere((ubicacion) =>
                                      ubicacion.provincia == _selectedProvincia)
                                  .ciudad;
                            });
                          },
                          items: _list!
                              .map((ubicacion) => DropdownMenuItem(
                                    value: ubicacion.provincia,
                                    child: Text(ubicacion.provincia!),
                                  ))
                              .toList(),
                          decoration: InputDecoration(labelText: 'Provincia'),
                        ),
                        if (_ciudades != null && _selectedProvincia != null)
                          DropdownButtonFormField<String>(
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCiudad = newValue;
                                widget.info.ubicacion =
                                    ('${_selectedProvincia ?? ''},${_selectedCiudad ?? ''}');
                              });
                            },
                            items: _ciudades!
                                .map((ciudad) => DropdownMenuItem<String>(
                                      value: ciudad,
                                      child: Text(ciudad),
                                    ))
                                .toList(),
                            decoration: InputDecoration(labelText: 'Ciudad'),
                          ),
                      ],
                    ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: calificacionController,
              onChanged: (value) {
                  calificacion= int.tryParse(value) ?? 0;
                
              },
              decoration: InputDecoration(labelText: 'Calificacion'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 16),
            TextField(
              controller: precioBaseController,
               onChanged: (value) {
                  precioBase= double.tryParse(value) ?? 0.00;
                
              },
              decoration: InputDecoration(labelText: 'Precio Base'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: descripcionController,
              onChanged: (value) => descripcion = value,
              decoration: InputDecoration(labelText: 'Descripccion'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: serviciosController,
              onChanged: (value) => servicios =
                  value.split(',').map((e) => e.trim()).toList(),
              decoration: InputDecoration(labelText: 'Servicios'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.info.nombre = nombre;
                widget.info.calificacion = calificacion;
                widget.info.precioBase = precioBase;
                widget.info.descripcion = descripcion;
                widget.info.servicios = servicios;

                print('Nombre ${widget.info.nombre}');
                print('Ubicación ${widget.info.ubicacion}');
                print('Calificación ${widget.info.calificacion}');
                print('Precio Base ${widget.info.precioBase}');
                print('Calificación ${widget.info.descripcion}');
                print('Calificación ${widget.info.servicios}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisponibilidadFormUpdate(
                      hotel: widget.hotel,
                      hotelId: widget.hotelId,
                      info: widget.info,
                      disponibilidad: widget.disponibilidad,
                      contacto: widget.contacto,
                      fotografia: widget.fotografia,
                      actualizarHotelScreen: widget.actualizarHotelScreen,
                    ),
                  ),
                );
              },
              child: Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }
}
