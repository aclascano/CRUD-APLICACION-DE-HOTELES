import 'package:flutter/material.dart';
import 'package:proyectofinal/src/widgets/lista_hoteles.dart';

import 'añadir_hotel.dart';


class HotelesScreen extends StatefulWidget {
  @override
  _HotelesScreenState createState() => _HotelesScreenState();
}
class _HotelesScreenState extends State<HotelesScreen> {
  String selectedOption = 'Lista de Hoteles'; // Opción seleccionada por defecto

  Widget _getBodyContent() {
    if (selectedOption == 'Lista de Hoteles') {
      return HotelesList(); // Mostrar la lista de hoteles
    } else if (selectedOption == 'Añadir un hotel') {
      return AgregarHotelScreen(); // Mostrar la pantalla para añadir un hotel
    } else {
      return Container(); // Por defecto, mostrar un contenedor vacío
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Hoteles',
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('Lista de Hoteles'),
              onTap: () {
                setState(() {
                  selectedOption = 'Lista de Hoteles';
                });
                Navigator.pop(context); // Cerrar el drawer
              },
            ),
            ListTile(
              title: Text('Añadir un hotel'),
              onTap: () {
                setState(() {
                  selectedOption = 'Añadir un hotel';
                });
                Navigator.pop(context); // Cerrar el drawer
              },
            ),
          ],
        ),
      ),
      body: _getBodyContent(),
    );
  }
}
