import 'package:flutter/material.dart';

/// App-wide GIF loader. Replaces CircularProgressIndicator across all screens.
/// Centered by default; pass [centered: false] for inline use inside buttons
/// or other widgets that already provide their own alignment.
class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.size = 500, this.centered = true});

  final double size;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final img = Image.asset(
      'assets/images/loader.gif',
      width: size,
      height: size,
    );
    return centered ? Center(child: img) : img;
  }
}
