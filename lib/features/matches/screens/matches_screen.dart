import 'package:flutter/material.dart';
import 'package:socaloca/core/constants/app_strings.dart';

// TODO: Implement MatchesScreen
// See flutter_migration_docs/screens/ for full spec
class MatchesScreen extends StatelessWidget {
  MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Matches'.tr)),
      body: Center(child: Text('TODO: Implement Matches'.tr)),
    );
  }
}
