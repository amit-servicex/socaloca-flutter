import 'dart:async';

import 'package:flutter/material.dart';

class AppToast {
  AppToast._();

  static OverlayEntry? _entry;
  static Timer? _timer;

  static void show(
    BuildContext context,
    String message, {
    bool long = false,
  }) {
    final overlay = Overlay.maybeOf(context);
    if (overlay == null || message.isEmpty) return;

    _timer?.cancel();
    _entry?.remove();

    _entry = OverlayEntry(
      builder: (context) => _ToastOverlay(message: message),
    );
    overlay.insert(_entry!);

    _timer = Timer(Duration(milliseconds: long ? 3500 : 2000), () {
      _entry?.remove();
      _entry = null;
    });
  }
}

class _ToastOverlay extends StatelessWidget {
  const _ToastOverlay({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      right: 24,
      bottom: MediaQuery.of(context).padding.bottom + 72,
      child: IgnorePointer(
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xD1000000),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
