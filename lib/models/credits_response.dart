import 'dart:convert';

class CreditsResponse {
  CreditsResponse({
    required this.id,
    required this.cast,
  });

  int id;
  List<Cast> cast;

  factory CreditsResponse.fromJson(String str) =>
      CreditsResponse.fromMap(json.decode(str));

  factory CreditsResponse.fromMap(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
      );
}

class Cast {
  Cast({
    required this.id,
    required this.name,
    this.profilePath,
    required this.character,
  });

  int id;
  String name;
  String? profilePath;
  String character;

  get fullProfilePath {
    if (profilePath != null) {
      return 'https://image.tmdb.org/t/p/w185$profilePath';
    }
    return 'assets/no-image.jpg';
  }

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        id: json["id"],
        name: json["name"],
        profilePath: json["profile_path"],
        character: json["character"],
      );
}
