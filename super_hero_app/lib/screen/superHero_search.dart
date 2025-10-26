import 'package:flutter/material.dart';
import 'package:super_hero_app/data/model/superhero_detail_response.dart';
import 'package:super_hero_app/data/model/superhero_response.dart';
import 'package:super_hero_app/data/repository.dart';
import 'package:super_hero_app/screen/superhero_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SuperHeroSearch extends StatefulWidget {
  const SuperHeroSearch({super.key});

  @override
  State<SuperHeroSearch> createState() => _SuperHeroSearchState();
}

class _SuperHeroSearchState extends State<SuperHeroSearch> {
  Future<SuperheroResponse?>? _SuperHeroInfo;
  Repository repository = Repository();
  bool _IsTextEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SuperHero Search")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Busca un superhéroe",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                setState(() {
                  _IsTextEmpty = text.isEmpty;
                  _SuperHeroInfo = repository.fetchSuperHeroInfo(text);
                });
              },
            ),
          ),
          BodyList(_IsTextEmpty),
        ],
      ),
    );
  }

  FutureBuilder<SuperheroResponse?> BodyList(bool IsTextEmpty) {
    return FutureBuilder(
      future: _SuperHeroInfo,
      builder: (context, snapshot) {
        if (IsTextEmpty) {
          return Text("Introduce un nombre");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else if (snapshot.hasData) {
          var superheroList = snapshot.data?.result;
          return Expanded(
            child: ListView.builder(
              itemCount: superheroList?.length ?? 0,
              itemBuilder: (context, index) {
                if (superheroList != null) {
                  return itemSuperhero(superheroList[index]);
                } else {
                  return Text("Error");
                }
              },
            ),
          );
        } else {
          return Text("No hay resultados");
        }
      },
    );
  }

  Padding itemSuperhero(SuperheroDetailResponse item) => Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuperheroDetail(superhero: item),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 240, 66, 14), 
              Color.fromARGB(255, 204, 122, 29), 
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.urlM,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
