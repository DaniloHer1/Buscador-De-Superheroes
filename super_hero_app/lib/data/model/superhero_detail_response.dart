class SuperheroDetailResponse {
  final String id;
  final String name;
  final String urlM;
  final String urlXL;
  final String realName;
  final PowerStatsResponse powerStatsResponse;

  SuperheroDetailResponse({
    required this.id,
    required this.name,
    required this.urlM,
    required this.urlXL,
    required this.realName,
    required this.powerStatsResponse,
  });

  factory SuperheroDetailResponse.fromJson(Map<String, dynamic> json) {
    return SuperheroDetailResponse(
      id: json["id"]?.toString() ?? '',
      name: json["name"] ?? '',
      urlM: json["images"]?["md"] ?? '',
      urlXL: json["images"]?["lg"] ?? '',
      realName: json["biography"]["fullName"],
      powerStatsResponse: PowerStatsResponse.fromJson(json["powerstats"]));
  }
}

class PowerStatsResponse {
  final int intelligence;
  final int strength;
  final int speed;
  final int durability;
  final int power;
  final int combat;

  PowerStatsResponse({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  factory PowerStatsResponse.fromJson(Map<String, dynamic> json) {
    return PowerStatsResponse(
      intelligence: json["intelligence"] ?? '',
      strength: json["strength"] ?? '',
      speed: json["speed"] ?? '',
      durability: json["durability"] ?? '',
      power: json["power"] ?? '',
      combat: json["combat"] ?? '',
    );
  }
}
