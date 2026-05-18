import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

// TODO: Implement ScoutScreen
// See flutter_migration_docs/screens/ for full spec
class ScoutScreen extends StatelessWidget {
  ScoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scout'.tr)),
      body: Center(child: Text('TODO: Implement Scout'.tr)),
    );
  }
}
