class CinemaSeat {
  final String id;
  final String row;
  final int number;
  final SeatCategory category;
  SeatStatus status;

  CinemaSeat({
    required this.id,
    required this.row,
    required this.number,
    required this.category,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'row': row,
      'number': number,
      'category': category.toString(),
      'status': status.toString(),
    };
  }

  factory CinemaSeat.fromMap(Map<String, dynamic> map) {
    return CinemaSeat(
      id: map['id'] ?? '',
      row: map['row'] ?? '',
      number: map['number'] ?? 0,
      category: SeatCategory.values.firstWhere(
            (e) => e.toString() == map['category'],
        orElse: () => SeatCategory.Regular,
      ),
      status: SeatStatus.values.firstWhere(
            (e) => e.toString() == map['status'],
        orElse: () => SeatStatus.Available,
      ),
    );
  }
}

enum SeatCategory { VIP, Regular }
enum SeatStatus { Available, Booked, Selected }
