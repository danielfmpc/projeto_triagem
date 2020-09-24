

import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

class WindowSizeService {
  Future<void> initialize() async {
    getWindowInfo().then((window) {
      if (window.screen != null) {
        final frame = Rect.fromLTRB(1358.0, 0.0, 2740.0, 780.0);
        setWindowFrame(frame);
      }
    });
  }
}