import 'package:flutter/material.dart';
import 'package:super_hero_app/data/model/superhero_detail_response.dart';

class SuperheroDetail extends StatelessWidget {
  final SuperheroDetailResponse superhero;

  const SuperheroDetail({super.key, required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(("SuperHero ${superhero.name} "))),
      body: Column(
        children: [
          Image.network(
            superhero.urlXL,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Text(superhero.name, style: TextStyle(fontSize: 28)),
          Text(
            superhero.realName,
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),

          SizedBox(
            height: 130,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PaintHero(
                  superhero.powerStatsResponse.power.toDouble(),
                  const Color.fromARGB(255, 255, 0, 0),
                  "Power",
                ),
                PaintHero(
                  superhero.powerStatsResponse.intelligence.toDouble(),
                  const Color.fromARGB(255, 5, 172, 250),
                  "Intelligence",
                ),
                PaintHero(
                  superhero.powerStatsResponse.strength.toDouble(),
                  const Color.fromARGB(255, 108, 117, 126),
                  "Strength",
                ),
                PaintHero(
                  superhero.powerStatsResponse.speed.toDouble(),
                  const Color.fromARGB(255, 23, 241, 34),
                  "Speed",
                ),
                PaintHero(
                  superhero.powerStatsResponse.durability.toDouble(),
                  const Color.fromARGB(255, 252, 131, 33),
                  "Durability",
                ),
                PaintHero(
                  superhero.powerStatsResponse.combat.toDouble(),
                  Colors.black,
                  "Power",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column PaintHero(double intensidad, Color color, String texto) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(height: intensidad, width: 20, color: color),
        Text(texto),
      ],
    );
  }
}
