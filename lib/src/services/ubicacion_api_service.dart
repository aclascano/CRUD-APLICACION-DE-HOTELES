import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import '../models/ubicacion.dart';

class UbicacionService {
  UbicacionService();

  Future<List<Ubicacion>?> getUbicicacion() async {
    List<Ubicacion> result = [];
    try {
      var url = Uri.http('demo5629528.mockable.io', 'api/ubicacion');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          return result;
        } else {
          List<dynamic> ListBody = json.decode(response.body);
          for (var item in ListBody) {
            var NewAuto = Ubicacion.fromJson(item);
            result.add(NewAuto);
            
          }
          
        }
      } else {
        developer.log('Request failed with status: ${response.statusCode}.');
      }
      return result;
    } catch (ex) {
      developer.log(ex.toString());
      return null;
    }
  }
}
