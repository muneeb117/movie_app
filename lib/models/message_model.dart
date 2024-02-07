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

  // Factory constructor to create a Message object from a Firestore document snapshot
  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      text: data['message'] ?? '', // Ensure this matches your Firestore field
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Factory constructor to create a Message object from an MQTT payload string
  static Message fromString(String payload) {
    final parts = payload.split(':');
    if (parts.length < 3) {
      throw FormatException('Payload is not in the expected format.');
    }
    final userId = parts[0];
    final userName = parts[1];
    final text = parts.skip(2).join(':'); // Join back if ':' were part of the original message

    return Message(
      userId: userId,
      userName: userName,
      text: text,
      timestamp: DateTime.now(), // Approximation, actual timestamp is set when storing in Firestore
    );
  }

  // Method to convert a Message object into a map for Firestore storage
  Map<String, dynamic> toFirestoreMap() {
    return {
      'userId': userId,
      'userName': userName,
      'message': text,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
  String get uniqueId => "$userId-${timestamp.millisecondsSinceEpoch}";

  // Method to serialize the Message object into a string for MQTT transmission
  @override
  String toString() {
    return '$userId:$userName:$text';
  }
}
