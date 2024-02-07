
class Booking {
  String userId;
  String email;

  String userName;
  String hallName;
  DateTime date;
  List<String> selectedSeats;
  double totalPrice;

  Booking({
    required this.userId,
    required this.email,
    required this.userName,
    required this.hallName,
    required this.date,
    required this.selectedSeats,
    required this.totalPrice,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'email': email,
      'userName': userName,
      'hallName': hallName,
      'date': date,
      'selectedSeats': selectedSeats,
      'totalPrice': totalPrice,
    };
  }
}
