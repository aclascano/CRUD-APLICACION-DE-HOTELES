import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../data/hotelcontacto_data.dart';
import '../data/hoteldisponibilidad_data.dart';
import '../data/hotelfotografia_data.dart';
import '../data/hotelinfo_data.dart';
import '../models/ubicacion.dart';
import '../screens/añadir_hotel.dart';
import '../services/ubicacion_api_service.dart';
import 'disponibilidad_form.dart';

class InfoForm extends StatefulWidget {
  final Hotelinfo info;
  final HotelDisponibilidad disponibilidad;
  final HotelContacto contacto;
  final HotelFotografia fotografia;
  final AgregarHotelScreen agregarHotelScreen;

  const InfoForm({
    required this.info,
    required this.disponibilidad,
    required this.contacto,
    required this.fotografia,
    required this.agregarHotelScreen,
  });

  @override
  _InfoFormState createState() => _InfoFormState();
}


class _InfoFormState extends State<InfoForm> {
  

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController ubicacionController = TextEditingController();
  final TextEditingController calificacionController = TextEditingController();
  final TextEditingController precioBaseController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController serviciosController = TextEditingController();

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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Paso 1. Información del hotel'),
            SizedBox(height: 16),
            TextField(
              controller: nombreController,
              onChanged: (value) => widget.info.nombre = value,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
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
                        _selectedCiudad =
                            null; // Reiniciar la ciudad seleccionada cuando cambie la provincia
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
                        widget.info.ubicacion = ('${_selectedProvincia ?? ''},${_selectedCiudad ?? ''}');
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
              onChanged: (value) => widget.info.calificacion = int.tryParse(value),
              decoration: InputDecoration(labelText: 'Calificacion'),
              keyboardType: TextInputType.number, 
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly 
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: precioBaseController,
              onChanged: (value) => widget.info.precioBase = double.tryParse(value),
              decoration: InputDecoration(labelText: 'Precio Base'),
              keyboardType: TextInputType.numberWithOptions(decimal: true), 
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')), 
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: descripcionController,
              onChanged: (value) => widget.info.descripcion = value,
              decoration: InputDecoration(labelText: 'Descripccion'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: serviciosController,
              onChanged: (value) => widget.info.servicios =
                  value.split(',').map((e) => e.trim()).toList(),
              decoration: InputDecoration(labelText: 'Servicios'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                print(widget.info.ubicacion);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisponibilidadForm(
                      info: widget.info,
                      disponibilidad: widget.disponibilidad,
                      contacto: widget.contacto,
                      fotografia: widget.fotografia,
                      agregarHotelScreen: widget.agregarHotelScreen,
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
