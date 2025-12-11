// To parse this JSON data, do
//
//     final personaje = personajeFromJson(jsonString);

import 'dart:convert';

List<Personaje> personajeFromJson(String str) => List<Personaje>.from(json.decode(str).map((x) => Personaje.fromJson(x)));

String personajeToJson(List<Personaje> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Personaje {
  final Name name;
  final Images images;
  final Gender gender;
  final String species;
  final String? homePlanet;
  final String occupation;
  final List<String> sayings;
  final int id;
  final String age;

  Personaje({
    required this.name,
    required this.images,
    required this.gender,
    required this.species,
    this.homePlanet,
    required this.occupation,
    required this.sayings,
    required this.id,
    required this.age,
  });

  factory Personaje.fromJson(Map<String, dynamic> json) => Personaje(
    name: Name.fromJson(json["name"]),
    images: Images.fromJson(json["images"]),
    gender: genderValues.map[json["gender"]]!,
    species: json["species"],
    homePlanet: json["homePlanet"],
    occupation: json["occupation"],
    sayings: List<String>.from(json["sayings"].map((x) => x)),
    id: json["id"],
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "name": name.toJson(),
    "images": images.toJson(),
    "gender": genderValues.reverse[gender],
    "species": species,
    "homePlanet": homePlanet,
    "occupation": occupation,
    "sayings": List<dynamic>.from(sayings.map((x) => x)),
    "id": id,
    "age": age,
  };
}

enum Gender {
  FEMALE,
  MALE
}

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "Male": Gender.MALE
});

class Images {
  final String headShot;
  final String main;

  Images({
    required this.headShot,
    required this.main,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    headShot: json["head-shot"],
    main: json["main"],
  );

  Map<String, dynamic> toJson() => {
    "head-shot": headShot,
    "main": main,
  };
}

class Name {
  final String first;
  final String middle;
  final String last;

  Name({
    required this.first,
    required this.middle,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    first: json["first"],
    middle: json["middle"],
    last: json["last"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "middle": middle,
    "last": last,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
