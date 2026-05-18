import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

// TODO: Implement LiveMatchScreen
// See flutter_migration_docs/screens/ for full spec
class LiveMatchScreen extends StatelessWidget {
  LiveMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LiveMatch'.tr)),
      body: Center(child: Text('TODO: Implement LiveMatch'.tr)),
    );
  }
}
