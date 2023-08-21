
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/hotelcontacto_data.dart';
import '../../data/hoteldisponibilidad_data.dart';
import '../../data/hotelfotografia_data.dart';
import '../../data/hotelinfo_data.dart';
import '../../models/hotel.dart';
import '../../screens/actualizar_hotel.dart';
import 'fotografia_form.dart';

class ContactoFormUpdate extends StatelessWidget {
  final Hotel? hotel;
  final Hotelinfo info;
  final HotelDisponibilidad disponibilidad;
  final HotelContacto contacto;
  final HotelFotografia fotografia;
  final ActualizarHotelScreen actualizarHotelScreen;

  final TextEditingController correoController = TextEditingController();
  final TextEditingController numeroTelefonoController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController sitioWebController = TextEditingController();

  String correo = "";
  String numeroTelefono = "";
  String facebook= "";
  String instagram = "";
  String sitioWeb= "";

  final int hotelId;
  
  
  ContactoFormUpdate({
    required this.hotelId,
    required this.hotel,
    required this.info, 
    required this.disponibilidad,
    required this.contacto, 
    required this.fotografia,
    required this.actualizarHotelScreen});
  
  @override
  Widget build(BuildContext context) {

    correoController.text = hotel?.contacto?.correo.toString() ?? '';
    correo = hotel?.contacto?.correo ?? '';

    numeroTelefonoController.text = hotel?.contacto?.numeroTelefono ?? '';
    numeroTelefono = hotel?.contacto?.numeroTelefono ?? '';

    facebookController.text = hotel?.contacto?.facebook ?? '';
    facebook = hotel?.contacto?.facebook ?? '';

    instagramController.text = hotel?.contacto?.instagram ?? '';
    instagram = hotel?.contacto?.instagram ?? '';

    sitioWebController.text = hotel?.contacto?.sitioWeb.toString() ?? '';
    sitioWeb = hotel?.contacto?.sitioWeb ?? '';

    return SingleChildScrollView(
    
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Paso 3. Información sobre el Contacto'),
            SizedBox(height: 16),
             TextField(
              controller: correoController,
              onChanged: (value) => correo = value,
              decoration: InputDecoration(labelText: 'Correo de Contacto'),
              keyboardType: TextInputType.emailAddress,
              
            ),
            SizedBox(height: 16),
            TextField(
              controller: numeroTelefonoController,
              onChanged: (value) => numeroTelefono = value,
              decoration: InputDecoration(labelText: 'Número de Teléfono de Contacto'),
              keyboardType: TextInputType.number, 
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly 
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: facebookController,
              onChanged: (value) => facebook = value,
              decoration: InputDecoration(labelText: 'Facebook de Contacto'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: instagramController,
              onChanged: (value) => instagram = value,
              decoration: InputDecoration(labelText: 'Instagram de Contacto'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: sitioWebController,
              onChanged: (value) => sitioWeb = value,
              decoration: InputDecoration(labelText: 'Sitio Web de Contacto'),
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 16),
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
                    contacto.correo = correo;
                    contacto.numeroTelefono = numeroTelefono;
                    contacto.facebook = facebook;
                    contacto.instagram = instagram;
                    contacto.sitioWeb = sitioWeb;


                    if (correo.isEmpty || sitioWeb.isEmpty) {
                      // Validación: ningún campo puede estar vacío
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ningún campo puede estar vacío')),
                      );
                    } else if (!isValidEmail(correo)) {
                      // Validación: formato de correo electrónico inválido
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ingrese un correo electrónico válido')),
                      );
                    } else if (!isValidUrl(sitioWeb)) {
                      // Validación: formato de URL inválido
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ingrese una URL válida')),
                      );
                    } else {
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FotografiaFormUpdate(
                            hotel: hotel,
                            hotelId: hotelId,
                            info:info, 
                            disponibilidad: disponibilidad, 
                            contacto: contacto,
                            fotografia: fotografia, 
                            actualizarHotelScreen: actualizarHotelScreen),
                        ),
                      );
                    }
                    
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
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  bool isValidUrl(String url) {
    final urlRegExp = RegExp(
        r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$');
    return urlRegExp.hasMatch(url);
  }
}
