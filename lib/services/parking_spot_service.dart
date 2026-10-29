import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/parking_spot_model.dart';

class ParkingSpotService {
  String url = "https://parking-spot-pmfd.onrender.com/parking-spot";
  dynamic _response;

  ParkingSpotService() {
    _response = "";
  }

  // 01 - Listar todas as vagas (GET /parking-spot)
  Future<List<ParkingSpot>> fetchListParkingSpots() async {
    _response = await http.get(
      Uri.parse(url),
      headers: {'Accept': 'application/json'},
    );
    if (_response.statusCode == 200) {
      List<dynamic> returned = json.decode(utf8.decode(_response.bodyBytes));
      return returned.map((item) => ParkingSpot.fromJson(item)).toList();
    } else {
      throw Exception('Falhou ao carregar');
    }
  }

  // 02 - Cadastrar vaga (POST /parking-spot)
  Future<ParkingSpot> createParkingSpot(ParkingSpot spot) async {
    _response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode(spot.toJson()),
    );
    if (_response.statusCode == 201) {
      return ParkingSpot.fromJson(json.decode(utf8.decode(_response.bodyBytes)));
    } else {
      throw Exception('Falhou ao cadastrar');
    }
  }
  // 03 - Atualizar vaga (PUT /parking-spot/{id})
  Future<ParkingSpot> updateParkingSpot(String id, ParkingSpot spot) async {
    _response = await http.put(
      Uri.parse('$url/$id'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode(spot.toJson()),
    );
    if (_response.statusCode == 200) {
      return ParkingSpot.fromJson(json.decode(utf8.decode(_response.bodyBytes)));
    } else {
      throw Exception('Falhou ao atualizar');
    }
  }
}