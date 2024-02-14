import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/message_model.dart';
import '../../../models/user_detail_model.dart';
import '../../../services/mqtt_service.dart';

class ChatScreen extends StatefulWidget {
  final String movieId;
  final String movieName;

  const ChatScreen({Key? key, required this.movieId, required this.movieName})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late MQTTManager _mqttManager;
  List<Message> messages = [];
  final TextEditingController _messageController = TextEditingController();
  UserDetail? userDetail;

  @override
  void initState() {
    super.initState();
    fetchUserDetails().then((details) {
      if (details != null) {
        setState(() {
          userDetail = details;
        });
        _initializeMQTTClient();
        _fetchChatHistory();
      }
    });
  }

  Future<UserDetail?> fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userData.exists) {
        return UserDetail.fromMap(
            userData.data() as Map<String, dynamic>, user.uid);
      } else {
        Fluttertoast.showToast(msg: "User data not found.");
      }
    } else {
      Fluttertoast.showToast(msg: "No user is logged in.");
    }
    return null;
  }

  void _initializeMQTTClient() {
    if (userDetail != null) {
      _mqttManager = MQTTManager(
          server: 'broker.hivemq.com', clientId: userDetail!.userId);
      _mqttManager.initializeMQTTClient().then((connected) {
        if (connected) {
          _mqttManager.subscribeToTopic('movie/${widget.movieId}/chat');
          _listenForNewMessages();
        } else {
          Fluttertoast.showToast(msg: "Failed to connect to MQTT broker.");
        }
      });
    }
  }

  void _listenForNewMessages() {
    _mqttManager.messages.listen((messagePayload) {
      Message message = Message.fromString(messagePayload);
      if (!isMessagePresent(message)) {
        if (mounted) {
          setState(() {
            messages.add(message);
          });
        }
      }
    });
  }

  bool isMessagePresent(Message newMessage) {
    return messages.any((message) => message.uniqueId == newMessage.uniqueId);
  }

  void _fetchChatHistory() {
    FirebaseFirestore.instance
        .collection('chats/${widget.movieId}/messages')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
      List<Message> newMessages =
          snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
      if (mounted) {
        setState(() {
          messages.clear();
          messages.addAll(newMessages);
        });
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty && userDetail != null) {
      final payload =
          '${userDetail!.userId}:${userDetail!.name}:${_messageController.text}';
      _mqttManager.publishMessage('movie/${widget.movieId}/chat', payload);
      _storeMessageInFirestore(
          userDetail!.userId, userDetail!.name, _messageController.text);
      _messageController.clear();
    }
  }

  void _storeMessageInFirestore(
      String userId, String userName, String messageText) {
    final message = Message(
      userId: userId,
      userName: userName,
      text: messageText,
      timestamp: DateTime.now(),
    );

    FirebaseFirestore.instance
        .collection('chats/${widget.movieId}/messages')
        .add(message.toFirestoreMap())
        .catchError((error) {
      Fluttertoast.showToast(msg: "Failed to send message.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movieName)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) =>
                  _buildMessageTile(messages[index]),
            ),
          ),
          _buildMessageInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageTile(Message message) {
    final isCurrentUser = message.userId == userDetail?.userId;
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text("${message.userName}: ${message.text}",
            style:
                TextStyle(color: isCurrentUser ? Colors.white : Colors.black)),
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mqttManager.disconnect();
    super.dispose();
  }
}
