import 'package:flutter/material.dart';

class InterestHeader extends StatelessWidget {
  const InterestHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Interest Earned',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            '\$94.55',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}