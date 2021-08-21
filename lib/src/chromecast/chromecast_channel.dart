import 'dart:async';

import 'package:flutter/services.dart';
import 'package:qonvex_cast/qonvex_cast.dart';
import 'package:qonvex_cast/src/chromecast/chromecast_event.dart';
import 'package:qonvex_cast/src/chromecast/chromecast_platform.dart';
import 'package:stream_transform/stream_transform.dart';

class ChromeCastChannel extends ChromeCastPlatform {
  late MethodChannel channel = QonvexCast.castChannel;
  final _eventStreamController = StreamController<ChromeCastEvent>.broadcast();
  Stream<ChromeCastEvent> _events(int id) =>
      _eventStreamController.stream.where((event) => event.id == id);
  Future<void> init(int id) {
    channel.setMethodCallHandler((call) => _handleMethodCall(call, id));
    return channel.invokeMethod<void>('chromeCast#wait');
  }

  @override
  Future<void> addSessionListener({required int id}) {
    return channel.invokeMethod<void>('chromeCast#addSessionListener');
  }

  @override
  Future<void> removeSessionListener({required int id}) {
    return channel.invokeMethod<void>('chromeCast#removeSessionListener');
  }

  @override
  Stream<SessionStartedEvent> onSessionStarted({required int id}) {
    return _events(id).whereType<SessionStartedEvent>();
  }

  @override
  Stream<SessionEndedEvent> onSessionEnded({required int id}) {
    return _events(id).whereType<SessionEndedEvent>();
  }

  @override
  Stream<RequestDidCompleteEvent> onRequestCompleted({required int id}) {
    return _events(id).whereType<RequestDidCompleteEvent>();
  }

  @override
  Stream<RequestDidFailEvent> onRequestFailed({required int id}) {
    return _events(id).whereType<RequestDidFailEvent>();
  }

  @override
  Future<void> loadMedia(String url, {required int id}) {
    final Map<String, dynamic> args = {'url': url};
    return channel.invokeMethod<void>('chromeCast#loadMedia', args);
  }

  @override
  Future<void> play({required int id}) {
    return channel.invokeMethod<void>('chromeCast#play');
  }

  @override
  Future<void> pause({required int id}) {
    return channel.invokeMethod<void>('chromeCast#pause');
  }

  @override
  Future<void> seek(bool relative, double interval, {required int id}) {
    final Map<String, dynamic> args = {
      'relative': relative,
      'interval': interval
    };
    return channel.invokeMethod<void>('chromeCast#seek', args);
  }

  @override
  Future<void> stop({required int id}) {
    return channel.invokeMethod<void>('chromeCast#stop');
  }

  @override
  Future<bool> isConnected({required int id}) async {
    return await channel.invokeMethod<bool>('chromeCast#isConnected') ?? false;
  }

  @override
  Future<bool> isPlaying({required int id}) async {
    return await channel.invokeMethod<bool>('chromeCast#isPlaying') ?? false;
  }

  Future<dynamic> _handleMethodCall(MethodCall call, int id) async {
    switch (call.method) {
      case 'chromeCast#didStartSession':
        _eventStreamController.add(SessionStartedEvent(id));
        break;
      case 'chromeCast#didEndSession':
        _eventStreamController.add(SessionEndedEvent(id));
        break;
      case 'chromeCast#requestDidComplete':
        _eventStreamController.add(RequestDidCompleteEvent(id));
        break;
      case 'chromeCast#requestDidFail':
        _eventStreamController
            .add(RequestDidFailEvent(id, call.arguments['error']));
        break;
      default:
        throw MissingPluginException();
    }
  }
}
