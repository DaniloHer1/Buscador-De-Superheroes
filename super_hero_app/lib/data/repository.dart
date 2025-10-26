import 'dart:convert';

import 'package:super_hero_app/data/model/superhero_response.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<SuperheroResponse?> fetchSuperHeroInfo(String name) async {
    try {
      final response = await http.get(
        Uri.parse("https://akabab.github.io/superhero-api/api/all.json"),
      );
      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body) as List;

        var filteredHeros = decodedJson.where((hero) {
          String heroName = hero["name"].toString().toLowerCase().replaceAll("-", " ").trim();
          String searchName = name.toLowerCase();

          return heroName.contains(searchName);
        }).toList();

        if (filteredHeros.isEmpty) {
          return SuperheroResponse(response: "error", result: []);
        }

        Map<String, dynamic> adaptedResponse = {
          "response": "success",
          "results": filteredHeros,
        };

        SuperheroResponse superheroResponse = SuperheroResponse.fromJson(
          adaptedResponse,
        );
        return superheroResponse;
      } else {
        return null;
      }
    } catch (e) {
      print('Error en fetchSuperHeroInfo: $e');
      return null;
    }
  }
}
