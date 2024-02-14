import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String userId;
  final String userName;
  final String text;
  final DateTime timestamp;

  Message({
    required this.userId,
    required this.userName,
    required this.text,
    required this.timestamp,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      text: data['message'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  static Message fromString(String payload) {
    final parts = payload.split(':');
    if (parts.length < 3) {
      throw const FormatException('Payload is not in the expected format.');
    }
    final userId = parts[0];
    final userName = parts[1];
    final text = parts.skip(2).join(':');

    return Message(
      userId: userId,
      userName: userName,
      text: text,
      timestamp: DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'userId': userId,
      'userName': userName,
      'message': text,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
  String get uniqueId => "$userId-${timestamp.millisecondsSinceEpoch}";

  @override
  String toString() {
    return '$userId:$userName:$text';
  }
}
