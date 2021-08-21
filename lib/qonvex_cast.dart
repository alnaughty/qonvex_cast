library qonvex_cast;

import 'package:flutter/services.dart';
import 'package:qonvex_cast/src/chromecast/chromecast_channel.dart';
export 'package:qonvex_cast/src/chromecast/chromecast_controller.dart';
export 'package:qonvex_cast/src/airplay/air_play_button.dart';

class QonvexCast {
  static const MethodChannel castChannel = const MethodChannel('qonvex_cast');
  final ChromeCastChannel chromeCast = new ChromeCastChannel();
}
