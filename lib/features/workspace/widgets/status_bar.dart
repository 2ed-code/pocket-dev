import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  final String text;

  const StatusBar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: const Color(0xff007ACC),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            color: Colors.white,
            size: 10,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(
            Icons.flutter_dash,
            color: Colors.white,
            size: 16,
          ),
        ],
      ),
    );
  }
}
