import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

// TODO: Implement TrainingScreen
// See flutter_migration_docs/screens/ for full spec
class TrainingScreen extends StatelessWidget {
  TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Training'.tr)),
      body: Center(child: Text('TODO: Implement Training'.tr)),
    );
  }
}
