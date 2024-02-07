class CinemaHall {
  final String id;
  final String name;
  final List<String> vipSeatIds;
  final List<String> regularSeatIds;

  CinemaHall({
    required this.id,
    required this.name,
    required this.vipSeatIds,
    required this.regularSeatIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'vipSeatIds': vipSeatIds,
      'regularSeatIds': regularSeatIds,
    };
  }

  factory CinemaHall.fromMap(Map<String, dynamic> map) {
    return CinemaHall(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      vipSeatIds: List<String>.from(map['vipSeatIds'] ?? []),
      regularSeatIds: List<String>.from(map['regularSeatIds'] ?? []),
    );
  }
}
