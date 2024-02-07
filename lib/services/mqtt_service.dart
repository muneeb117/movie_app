import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTManager {
  late MqttServerClient _client;
  final String _server;
  final String _clientId;

  final StreamController<String> _messageController = StreamController<String>.broadcast();

  MQTTManager({required String server, required String clientId})
      : _server = server,
        _clientId = clientId;

  Future<bool> initializeMQTTClient() async {
    _client = MqttServerClient.withPort(_server, _clientId, 1883)
      ..logging(on: false)
      ..keepAlivePeriod = 20
      ..onDisconnected = _onDisconnected
      ..onConnected = _onConnected
      ..onSubscribed = _onSubscribed;

    final connMessage = MqttConnectMessage()
        .withWillTopic('willtopic/$_clientId')
        .withWillMessage('$_clientId disconnected unexpectedly')
        .withWillQos(MqttQos.atLeastOnce);
    _client.connectionMessage = connMessage;

    try {
      await _client.connect();
    } catch (e) {
      print('MQTTManager::Error connecting: ${e.toString()}');
      return false;
    }

    if (_client.connectionStatus?.state == MqttConnectionState.connected) {
      print('MQTTManager::Connected');
      _setupOnMessage();
      return true;
    } else {
      print('MQTTManager::Error connecting to MQTT broker.');
      _client.disconnect();
      return false;
    }
  }

  void _onConnected() {
    print('MQTTManager::Connected');
  }

  void _onDisconnected() {
    print('MQTTManager::Disconnected');
  }

  void _onSubscribed(String topic) {
    print('MQTTManager::Subscribed to $topic');
  }

  void subscribeToTopic(String topic) {
    if (_client.connectionStatus?.state == MqttConnectionState.connected) {
      _client.subscribe(topic, MqttQos.exactlyOnce);
    } else {
      print("MQTTManager::subscribeToTopic - MQTT client is not connected.");
    }
  }

  void publishMessage(String topic, String message) {
    if (_client.connectionStatus?.state == MqttConnectionState.connected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      _client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
    } else {
      print("MQTTManager::publishMessage - MQTT client is not connected.");
    }
  }

  void _setupOnMessage() {
    _client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String message = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      final String topic = c[0].topic;
      print('MQTTManager::New message: $message from topic: "$topic"');
      _messageController.add(message);
    });
  }

  Stream<String> get messages => _messageController.stream;

  void disconnect() {
    _client.disconnect();
    _messageController.close();
    print("MQTTManager::Disconnected");
  }
}
