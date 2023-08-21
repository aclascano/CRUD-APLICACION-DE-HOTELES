import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/hotel_bloc.dart';
import '../../data/hotelcontacto_data.dart';
import '../../data/hoteldisponibilidad_data.dart';
import '../../data/hotelfotografia_data.dart';
import '../../data/hotelinfo_data.dart';
import '../../models/contacto.dart';
import '../../models/disponibilidad.dart';
import '../../models/hotel.dart';
import '../../screens/actualizar_hotel.dart';
import '../../services/hotel_service.dart';
import '../../services/imagenes_service.dart';


class FotografiaFormUpdate extends StatefulWidget {
  final Hotel? hotel;
  final Hotelinfo info;
  final HotelFotografia fotografia;
  final HotelDisponibilidad disponibilidad;
  final HotelContacto contacto;
  final ActualizarHotelScreen actualizarHotelScreen;

  final int hotelId;

  final HotelManager hotelManager = HotelManager();

  FotografiaFormUpdate({
    required this.hotel,
    required this.info,
    required this.disponibilidad,
    required this.contacto,
    required this.fotografia,
    required this.actualizarHotelScreen,
    required this.hotelId
  });

  @override
  _FotografiaFormUpdateState createState() => _FotografiaFormUpdateState();
}

class _FotografiaFormUpdateState extends State<FotografiaFormUpdate> {
  final HotelService _hotelService = HotelService();
  final TextEditingController urlFotografiaController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  late ImageUploadService _imageUploadService;

  String urlFotografia = "";
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _imageUploadService = ImageUploadService();
  }

  Future<void> _selectImage() async {
    final XFile? imageFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _selectedImage = File(imageFile.path);
      });
    }
  }

  Future<void> _captureImage() async {
    final XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      setState(() {
        _selectedImage = File(imageFile.path);
      });
    }
  }

  Future<void> _uploadImage(BuildContext context) async {
    if (_selectedImage != null) {
      String? downloadUrl =
          await _imageUploadService.uploadImage(_selectedImage!);
      if (downloadUrl != null) {
        setState(() {
          widget.fotografia.fotografia = downloadUrl;
          urlFotografiaController.text = downloadUrl;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Imagen subida con éxito')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error al subir la imagen')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    urlFotografiaController.text = widget.hotel?.fotografia ?? '';
    urlFotografia = widget.hotel?.fotografia ?? '';

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Text(
              'Paso 4. Sube una foto del hotel',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            TextField(
              controller: urlFotografiaController,
              onChanged: (value) => urlFotografia = value,
              decoration: InputDecoration(labelText: 'URL de la Fotografía'),
            ),
            SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    _captureImage();
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text('Camara'),
                  style: ElevatedButton.styleFrom(
                    
                    onPrimary: Colors.white, 
                    padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20), 
                    textStyle:
                        TextStyle(fontSize: 14), 
                  ),
                ),
                SizedBox(width: 30),

                ElevatedButton.icon(
                  onPressed: () {
                    _selectImage();
                  },
                  icon: Icon(Icons.photo_library),
                  label: Text('Galería'),
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                ),
              ]),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: (){
                _uploadImage(context);
                },
              icon: Icon(Icons.upload_file),
              label: Text('Cargar imagen'),
              
            ),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 188, 175, 136),
                    onPrimary: Colors.black,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  label: Text(''),
                  
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    widget.fotografia.fotografia = urlFotografia;

                    if(urlFotografia.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Debe cargar una imagen o ingresar un nuevo link')),
                      );
                    }
                    else{
                      actualizarHotel();
                    }
                    
                  },
                  icon: Icon(Icons.update),
                  label: Text('Actualizar Hotel'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 119, 217, 43),
                    onPrimary: Colors.black,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void actualizarHotel() async {
    final Hotel nuevoHotel = Hotel(
      nombre: widget.info.nombre,
      ubicacion: widget.info.ubicacion,
      calificacion: widget.info.calificacion,
      precioBase: widget.info.precioBase,
      descripcion: widget.info.descripcion,
      servicios: widget.info.servicios,
      contacto: Contacto(
        correo: widget.contacto.correo,
        numeroTelefono: widget.contacto.numeroTelefono,
        facebook: widget.contacto.facebook,
        instagram: widget.contacto.instagram,
        sitioWeb: widget.contacto.sitioWeb,
      ),
      disponibilidad: FechaDisponibilidad(
        startRange: widget.disponibilidad.startRange,
        endRange: widget.disponibilidad.endRange,
      ),
      fotografia: widget.fotografia.fotografia,
    );

    try {
      List<Hotel> hotelesExistentes = await _hotelService.getHotels();
      bool nombreRepetido =
          hotelesExistentes.any((h) => h.nombre == nuevoHotel.nombre);
      if (nombreRepetido) {
        throw Exception('Ya existe un hotel con el mismo nombre.');
      }

      await _hotelService.updateHotelByIndex(widget.hotelId,nuevoHotel);
      print('Disponibilidad: ${widget.disponibilidad.startRange}');
      print('Disponibilidad: ${widget.disponibilidad.endRange}');
      print(nuevoHotel.disponibilidad?.startRange);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Hotel Agregado'),
          content: Text('El hotel se ha agregado exitosamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el diálogo
              },
              child: Text('Aceptar'),
            ),
          ],
        ),
      );
    } catch (e) {
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error al actualizar el hotel'),
          content: Text(
            'Ha ocurrido un error al agregar el hotel. Por favor, inténtalo nuevamente.\nError: $e',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar'),
            ),
          ],
        ),
      );
    }
  }
}
