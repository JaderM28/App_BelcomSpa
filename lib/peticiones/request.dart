import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String url;
  final String model;

  ApiService(this.url, this.model);

  Future<List<dynamic>> getPeticion() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> codeData = json.decode(response.body);
      return codeData[model] ?? [];
    } else {
      throw Exception(
          'Faild to load data. Status Code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> getIdPeticion(String id) async {
    final response = await http.get(Uri.parse("$url/$id"));

    if (response.statusCode == 200) {
      Map<String, dynamic> codeData = json.decode(response.body);
      return codeData[model] ?? [];
    } else {
      throw Exception(
          'Faild to load data. Status Code: ${response.statusCode}');
    }
  }

  Future<bool> postPeticion(Map datos) async {
    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(datos));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error durante la solicitud Post');
    }
  }

  Future<bool> putPeticion(Map datos) async {
    try {
      var response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(datos),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error durante la solicitud Put');
    }
  }

  Future<bool> deletePeticion(Map id) async {
    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(id),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error durante la solicitud Delete');
    }
  }
}
