import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

// TODO: Implement CupsScreen
// See flutter_migration_docs/screens/ for full spec
class CupsScreen extends StatelessWidget {
  const CupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cups'.tr)),
      body: Center(child: Text('TODO: Implement Cups'.tr)),
    );
  }
}
