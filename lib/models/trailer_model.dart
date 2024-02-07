class Trailer {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;

  Trailer({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
  });

  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      id: json['id'] as String,
      key: json['key'] as String,
      name: json['name'] as String,
      site: json['site'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'name': name,
      'site': site,
      'type': type,
    };
  }

  String getTrailerUrl() {
    return site.toLowerCase() == 'youtube' ? 'https://www.youtube.com/watch?v=$key' : '';
  }
}
