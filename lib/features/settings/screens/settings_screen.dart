import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

// TODO: Implement SettingsScreen
// See flutter_migration_docs/screens/ for full spec
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'.tr)),
      body: Center(child: Text('TODO: Implement Settings'.tr)),
    );
  }
}
