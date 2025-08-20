import 'package:flutter/material.dart';
import '../models/interest_history_item.dart';

class InterestListTile extends StatelessWidget {
  final InterestHistoryItem item;

  const InterestListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple.withOpacity(0.1),
          child: const Icon(
            Icons.trending_up,
            color: Colors.deepPurple,
          ),
        ),
        title: Text(
          item.amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(item.date),
        trailing: Text(
          item.status,
          style: TextStyle(
            color: item.status == 'Credited' ? Colors.green : Colors.orange,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}