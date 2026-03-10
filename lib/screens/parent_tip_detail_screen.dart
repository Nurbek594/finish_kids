import 'package:flutter/material.dart';
import '../models/parent_tip_model.dart';
import '../theme/app_theme.dart';

class ParentTipDetailScreen extends StatelessWidget {
  final ParentTipModel tip;

  const ParentTipDetailScreen({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tip.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          tip.description,
          style: const TextStyle(
            fontSize: 16,
            height: 1.7,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}