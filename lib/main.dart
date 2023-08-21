import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyectofinal/src/screens/a%C3%B1adir_hotel.dart';
import 'package:proyectofinal/src/screens/hoteles_index.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Aplicacion de Moviles',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      useMaterial3: true,
    ),
    home: Scaffold(
      body: const MyHomePage(title: 'HOTELES APP'),
    ),
  );
}

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar( 
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hotel), 
            SizedBox(width: 8), 
            Text(
              'HOTELES APP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: HotelesScreen()
     
    );
  }
}
