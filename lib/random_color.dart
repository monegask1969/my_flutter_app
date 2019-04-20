
import 'dart:math';

import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';
import 'package:my_flutter_app/color_info.dart';

///
/// Generate random colors that are visually appealing
///
class RandomColor {
  /// Constructor for random generator
  /// [seed] Random seed to use for generating colors
  RandomColor([int seed]) {
    if (seed != null) {
      _random = new Random(seed);
    }

    _random ??= new Random();
  }

  bool debug = false;

  final int minBrightness = 16;
  final int maxBrightness = 84;
  Random _random;

  ///
  /// Get random color
  ///
  /// Optional arguments:
  /// [colorHue] Random color hue [Range] to use
  /// [colorSaturation] Random color saturation [Range]
  /// [colorBrightness] Random color brightness [Range]
  /// [debug] debug color creation. defaults to false
  ///
  Color randomColor({
    ColorHue colorHue,
    ColorSaturation colorSaturation,
    ColorBrightness colorBrightness,
    bool debug = false,
  }) {
    colorHue ??= ColorHue.random;
    colorSaturation ??= ColorSaturation.random;
    colorBrightness ??= ColorBrightness.random;

    this.debug = debug;

    int s;
    int h;
    int b;

    h = colorHue.returnHue(_random);
    s = colorSaturation.returnSaturation(_random);
    b = colorBrightness.returnBrightness(_random);

    _log('Color hue: $h');
    _log('Color saturation: $s');
    _log('Color brightness: $b');

    return _getColor(h, s, b);
  }

  /// Get list of random colors
  /// Calls [randomColor] for [count] number of times.
  /// [count] Number of colors
  List<Color> randomColors({
    @required int count,
    ColorHue colorHue,
    ColorSaturation colorSaturation,
    ColorBrightness colorBrightness,
    bool debug = false,
  }) {
    final List<Color> colors = <Color>[];

    for (int i = 0; i < count; i++) {
      colors.add(randomColor(
          colorHue: colorHue,
          colorSaturation: colorSaturation,
          colorBrightness: colorBrightness,
          debug: debug));
    }

    return colors;
  }

  /// Need to get RGB from hsv values and make new color from them.
  Color _getColor(int hue, int saturation, int brightness) {
    final double s = saturation / 100;
    final double v = brightness / 100;

    final Color _color = HSLColor.fromAHSL(1.0, hue.toDouble(), s, v).toColor();

    return _color;
  }

  void _log(String s) {
    if (debug) {
      print('Random color: $s');
    }
  }
}