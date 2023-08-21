import 'package:flutter/material.dart';
import '../bloc/hotel_bloc.dart';
import '../data/hotelcontacto_data.dart';
import '../data/hoteldisponibilidad_data.dart';
import '../data/hotelfotografia_data.dart';
import '../data/hotelinfo_data.dart';
import '../models/hotel.dart';
import '../widgets/actualizar/contacto_form.dart';
import '../widgets/actualizar/disponibilidad_form.dart';
import '../widgets/actualizar/fotografia_form.dart';
import '../widgets/actualizar/info_form.dart';

class ActualizarHotelScreen extends StatefulWidget {
  final int hotelId;

  ActualizarHotelScreen({required this.hotelId});

  @override
  _ActualizarHotelScreenState createState() => _ActualizarHotelScreenState();
}

class _ActualizarHotelScreenState extends State<ActualizarHotelScreen> {

  Hotel? _hotel;
  
  final Hotelinfo info = Hotelinfo();
  final HotelDisponibilidad disponibilidad = HotelDisponibilidad();
  final HotelContacto contacto = HotelContacto();
  final HotelFotografia fotografia = HotelFotografia();
  final HotelManager hotelService = HotelManager();

  @override
  void initState() {
    super.initState();
    _getHotelInfo();
  }

  Future<void> _getHotelInfo() async {
    try {
      Hotel? hotel = await hotelService.getHotelDetailByIndex(widget.hotelId);
      setState(() {
        _hotel = hotel;
      });
    } catch (e) {
      print('Error al obtener información del hotel: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Actualizar Hotel',
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Navigator(
            pages: [
              MaterialPage(
                  child: FotografiaFormUpdate(
                      hotel: _hotel,
                      hotelId: widget.hotelId,
                      info: info,
                      disponibilidad: disponibilidad,
                      contacto: contacto,
                      fotografia: fotografia,
                      actualizarHotelScreen: widget)),
              MaterialPage(
                  child: ContactoFormUpdate(
                      hotel: _hotel,
                      hotelId: widget.hotelId,
                      info: info,
                      disponibilidad: disponibilidad,
                      contacto: contacto,
                      fotografia: fotografia,
                      actualizarHotelScreen: widget)),
              MaterialPage(
                  child: DisponibilidadFormUpdate(
                      hotel: _hotel,
                      hotelId: widget.hotelId,
                      info: info,
                      disponibilidad: disponibilidad,
                      contacto: contacto,
                      fotografia: fotografia,
                      actualizarHotelScreen: widget)),
              MaterialPage(
                  child: InfoFormUpdate(
                      hotel: _hotel,
                      hotelId: widget.hotelId,
                      info: info,
                      disponibilidad: disponibilidad,
                      contacto: contacto,
                      fotografia: fotografia,
                      actualizarHotelScreen: widget)),
            ],
            onPopPage: (route, result) {
              if (!route.didPop(result)) {
                return false;
              }
              
              if (route.settings.name == '/fotografia') {
              } else if (route.settings.name == '/contacto') {
              } else if (route.settings.name == '/disponibilidad') {
                contacto.correo = null;
              }

              return true;
            },
          )),
    );
  }
}

final appTheme = ThemeData(
  primarySwatch: Colors.brown,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
    labelStyle: TextStyle(color: Colors.grey),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
    ),
  ),
);
