import 'package:flutter/material.dart';

class ItemTranslatorPage extends StatelessWidget {
  const ItemTranslatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('item translator page'),
            ],
          ),
        ],
      ),
    );
  }
}